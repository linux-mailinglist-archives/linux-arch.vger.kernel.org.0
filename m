Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6FE1D21
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2019 15:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406048AbfJWNpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Oct 2019 09:45:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:8979 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406042AbfJWNpH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Oct 2019 09:45:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 06:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,221,1569308400"; 
   d="scan'208";a="191833014"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga008.jf.intel.com with ESMTP; 23 Oct 2019 06:45:06 -0700
Date:   Wed, 23 Oct 2019 06:45:06 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [patch V2 02/17] x86/entry/64: Remove pointless jump in
 paranoid_exit
Message-ID: <20191023134505.GB329@linux.intel.com>
References: <20191023122705.198339581@linutronix.de>
 <20191023123117.779277679@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023123117.779277679@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 23, 2019 at 02:27:07PM +0200, Thomas Gleixner wrote:
> Jump directly to restore_regs_and_return_to_kernel instead of making
> a pointless extra jump through .Lparanoid_exit_restore
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
