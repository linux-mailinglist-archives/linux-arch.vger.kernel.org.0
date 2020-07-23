Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CA722BA40
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGWXlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 19:41:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:33453 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgGWXlN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 19:41:13 -0400
IronPort-SDR: bexZn88eOt8+lqqfi9shkMOnsyLC6DJ5J2DMYj+ycIVmlnwLis6yJ/olbuVKGvioqVfucjWzAC
 paQqTXDgqCkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="130199797"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="130199797"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 16:41:11 -0700
IronPort-SDR: ICl9mgStiUUD/7UH+Kc2+eojWglyclCDDkUGQAAjpjA/mPm4pmzkAPxio+t1ahqQIU2AdsR+4b
 4GK4HVqXdTxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="302485243"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga002.jf.intel.com with ESMTP; 23 Jul 2020 16:41:11 -0700
Date:   Thu, 23 Jul 2020 16:41:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V5 08/15] x86/entry: Move user return notifier out of loop
Message-ID: <20200723234111.GJ21891@linux.intel.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.159112003@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722220520.159112003@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 23, 2020 at 12:00:02AM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Guests and user space share certain MSRs. KVM sets these MSRs to guest
> values once and does not set them back to user space values on every VM
> exit to spare the costly MSR operations.
> 
> User return notifiers ensure that these MSRs are set back to the correct
> values before returning to user space in exit_to_usermode_loop().
> 
> There is no reason to evaluate the TIF flag indicating that user return
> notifiers need to be invoked in the loop. The important point is that they
> are invoked before returning to user space.
> 
> Move the invocation out of the loop into the section which does the last
> preperatory steps before returning to user space. That section is not
> preemptible and runs with interrupts disabled until the actual return.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
