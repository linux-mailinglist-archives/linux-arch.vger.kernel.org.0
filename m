Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82AC1DEDB0
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgEVQxE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 12:53:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45748 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbgEVQxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 12:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DATMXvPBFN2+b2MxvEm54Fwd6smgejl5nHlaR7B/mQ0=; b=Pg7zV9Cm25CEnqqgnteZ4rkSsJ
        jW2xOn9ek07x0YLY9VOBqy/4T6f73bD7ddQVsHHMkRXrV7cpzYxoICoveu44T0Br4ZhNKlX3qlKSS
        aZErt43QdZUXpfE6yHIRby4AL78iDFQtFdl0tauMNHd4niRm4M4QgZNHSArC9OOBJOQeMiIKlLfKX
        yw2zOkesdkRGucqKlIxDGQvOc+hj1R2PdbWMzcs1mLYFL+t9kVLcYTwk0AU66ZB+7M1IpZvenY0YJ
        6ruhazJA70OMSBAj97tUfjlrBUiYS+QT/ByLBhHHSzIChVTWXowwaKMLU/RVRKB62IM8sUfNltnqq
        DopPt9Gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcArr-0006XR-GU; Fri, 22 May 2020 16:49:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8E3C93060FC;
        Fri, 22 May 2020 18:49:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A55D20BDB125; Fri, 22 May 2020 18:49:53 +0200 (CEST)
Date:   Fri, 22 May 2020 18:49:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
Message-ID: <20200522164953.GA411971@hirez.programming.kicks-ass.net>
References: <20200429220732.31602-2-yu-cheng.yu@intel.com>
 <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
 <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
 <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
 <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
 <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
 <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
 <6272c481-af90-05c5-7231-3ba44ff9bd02@citrix.com>
 <CAMe9rOqwbxis1xEWbOsftMB9Roxdb3=dp=_MgK8z2pwPP36uRw@mail.gmail.com>
 <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ce9863-6ada-2bc4-5141-122f64292aba@citrix.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 16, 2020 at 03:09:22PM +0100, Andrew Cooper wrote:

> Sadly, the same is not true for kernel shadow stacks.
> 
> SSP is 0 after SYSCALL, SYSENTER and CLRSSBSY, and you've got to be
> careful to re-establish the shadow stack before a CALL, interrupt or
> exception tries pushing a word onto the shadow stack at 0xfffffffffffffff8.

Oh man, I can only imagine the joy that brings to #NM and friends :-(
