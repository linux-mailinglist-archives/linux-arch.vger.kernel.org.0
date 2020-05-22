Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F051DEEE9
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 20:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbgEVSIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 14:08:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:13909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgEVSIx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 14:08:53 -0400
IronPort-SDR: eJVCjCp20ca0jhKCx/IZTrQcIS4efZj9TnouLOGlDtHR0ExKkZdsb7Od+jPwXNhzBSbtuBVukk
 3y99oEIFJj+g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 11:08:52 -0700
IronPort-SDR: rsGVLmR70qM3p6MZ2UxFhZdQolDM3dbo1Jm4avZG4utGzxS+gFz/y6WAwmnVCIJViXxyFRR6pN
 7D4ETTo5rkgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,422,1583222400"; 
   d="scan'208";a="269074834"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga006.jf.intel.com with ESMTP; 22 May 2020 11:08:51 -0700
Message-ID: <02d825344b39891cf9c084edce44db168cce45fe.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Fri, 22 May 2020 11:07:49 -0700
In-Reply-To: <202005221034.59F5DF75@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
         <202005221020.B578B8C6@keescook>
         <20200522172711.GA317569@hirez.programming.kicks-ass.net>
         <202005221034.59F5DF75@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-05-22 at 10:36 -0700, Kees Cook wrote:
> On Fri, May 22, 2020 at 07:27:11PM +0200, Peter Zijlstra wrote:
> > On Fri, May 22, 2020 at 10:22:51AM -0700, Kees Cook wrote:
> > 
> > > But yes, I think getting a copy of asm.h would be nice here. I don't
> > > think the WRITE_ONCE() is needed in this particular case. Hmm.
> > 
> > Paranoia on my end because I had no clue wth he wanted with his -O0
> > magic gunk.
> 
> Heh, yes, which is why I asked for many more comments. ;) I *think* it
> was entirely to control the stack (and ssp) behavior (i.e. don't inline,
> don't elide unused stack variables, etc).

Yes, that was the reason.

Yu-cheng

