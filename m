Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DC21D8BCE
	for <lists+linux-arch@lfdr.de>; Tue, 19 May 2020 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgERXri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 19:47:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:49255 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgERXri (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 19:47:38 -0400
IronPort-SDR: sdB39/SxIwmCj0lrIELXnAJyDmcHZEW8sGjT43CYpRS/MTS4xgZc80KHh8vP4NK3CC9t5wMHUS
 EQYv6v5DgXtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:37 -0700
IronPort-SDR: a/75CUBbMjozD92kCKohOYbINuo8CpBIovvYrJRyaHfmqmEieFFfsnNKlLmvQ6DkoJxMpBNBZm
 naLb/0VGqWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="342962843"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2020 16:47:36 -0700
Message-ID: <075c5757d6c4d3813f7ae45288b765d76de8b6fc.camel@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Mon, 18 May 2020 16:47:42 -0700
In-Reply-To: <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-2-yu-cheng.yu@intel.com>
         <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
         <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
         <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
         <b0581ddc-0d99-cbcf-278e-0be55ba939a0@intel.com>
         <44c055342bda4fb4730703f987ae35195d1d0c38.camel@intel.com>
         <32235ffc-6e6c-fb3d-80c4-a0478e2d0e0f@intel.com>
         <b09658f92eb66c1d1be509813939b9ed827f9cf0.camel@intel.com>
         <631f071c-c755-a818-6a97-b333eb1fe21c@intel.com>
         <0f751be6d25364c25ee4bddc425b61e626dcd942.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-05-15 at 19:53 -0700, Yu-cheng Yu wrote:
> On Fri, 2020-05-15 at 16:56 -0700, Dave Hansen wrote:
> > On 5/15/20 4:29 PM, Yu-cheng Yu wrote:
> > > [...]
> > > I have run them with CET enabled.  All of them pass, except for the following:
> > > Sigreturn from 64-bit to 32-bit fails, because shadow stack is at a 64-bit
> > > address.  This is understandable.
> > [...]
> > One a separate topic: You ran the selftests and one failed.  This is a
> > *MASSIVE* warning sign.  It should minimally be described in your cover
> > letter, and accompanied by a fix to the test case.  It is absolutely
> > unacceptable to introduce a kernel feature that causes a test to fail.
> > You must either fix your kernel feature or you fix the test.
> > 
> > This code can not be accepted until this selftests issue is rectified.

The x86/sigreturn test constructs 32-bit ldt entries, and does sigreturn from
64-bit to 32-bit context.  We do not have a way to construct a static 32-bit
shadow stack.  Why do we want that?  I think we can simply run the test with CET
disabled.

Yu-cheng


