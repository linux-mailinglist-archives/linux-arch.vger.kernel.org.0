Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF722BB28
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 02:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgGXAzs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 20:55:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:60096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728413AbgGXAzr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 20:55:47 -0400
IronPort-SDR: 8mgsDcFf1Rjhs12yF9VLGlYUw2Hi+n4ANDOkbIjRcrNXcWfcts7RClCdngdvtkI1ohrKnK72Z5
 YqC3TmUAhIiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="148135029"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="148135029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 17:55:47 -0700
IronPort-SDR: qTxdZ5wR1udQ71TCjEpfT8A32uEqdelvgA9a4q/SttokEKqsJ23MyjygcYN29bchiquhTudin6
 yoBtw421rm4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="288829366"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2020 17:55:46 -0700
Date:   Thu, 23 Jul 2020 17:55:46 -0700
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
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
Message-ID: <20200724005546.GL21891@linux.intel.com>
References: <20200722215954.464281930@linutronix.de>
 <20200722220520.979724969@linutronix.de>
 <20200724001736.GK21891@linux.intel.com>
 <87eep1vixp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eep1vixp.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 24, 2020 at 02:46:26AM +0200, Thomas Gleixner wrote:
> Sean,
> 
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> > On Thu, Jul 23, 2020 at 12:00:09AM +0200, Thomas Gleixner wrote:
> >> +		if (xfer_to_guest_mode_work_pending()) {
> >>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
> >> -			cond_resched();
> >> +			r = xfer_to_guest_mode(vcpu);
> >
> > Any reason not to call this xfer_to_guest_mode_work()?  Or handle_work(),
> > do_work(), etc...  Without the "work" part, it looks like a function that
> > should be invoked unconditionally.  It's obvious that's not the case if
> > one looks at the implementation, but it's a bit confusing on the KVM side
> > of things.
> 
> The reason is probably lazyness. The original approach was to have this
> as close as possible to user entry/exit but with the recent changes
> vs. instrumentation and RCU this is not longer the case.
> 
> I really want to keep the notion of transitioning in the function name,
> so xfer_to_guest_mode_handle_work() makes a lot of sense.
> 
> I'll change that before merging the lot into the tip tree if your
> Reviewed-by still stands with that change made w/o reposting.

Ya, works for me.
