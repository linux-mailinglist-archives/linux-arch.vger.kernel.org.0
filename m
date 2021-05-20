Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D430338B554
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhETRl0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 13:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhETRl0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 May 2021 13:41:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EAAC061574;
        Thu, 20 May 2021 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xAcCCkyhMBeA+FlHmzfzPiZtaAE/GIh+EEGr21kJE5o=; b=kec7QH+yYYLs8HscTdTqy33p4w
        T1gIXianzT7SRzE025+ho+dKtGojV6O7fz0WY6U02d1x4R0w6PPXeJ/0ok0XpA3cCDarg4tRh5GBr
        cthpgpsvrbhclUIffjijQrwOuFz6Jhhn39KVk7EGobhoXyhp4oEE22AFmbWERlukwx+6DUgvukwhb
        VJeYu8TQ85UA7x3vk76JRlQurkYo+nTmE1VZ7SQYXwFnrKIqlXm2tl3VGZJX7A8kPV+mJRiE4LaaU
        B8FFRD//81AgcAtZ0j7d2nJKVjXQNe+Pbvpw4CuLPs6qV6GOKVYGeWT0lmIbvS1PxHfVczpbYlPnj
        PGGtKssQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljmdO-00GG3I-8E; Thu, 20 May 2021 17:39:03 +0000
Date:   Thu, 20 May 2021 18:38:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v26 26/30] ELF: Introduce arch_setup_elf_property()
Message-ID: <YKaesoXCSBmCwD+4@casper.infradead.org>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-27-yu-cheng.yu@intel.com>
 <YKVUgzJ0MVNBgjDd@zn.tnic>
 <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 03:14:58PM -0700, Yu, Yu-cheng wrote:
> > > +++ b/include/uapi/linux/elf.h
> > > @@ -455,4 +455,13 @@ typedef struct elf64_note {
> > >   /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
> > >   #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
> > > +/* .note.gnu.property types for x86: */
> > > +#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
> > 
> > Why not 0xc0000001? ARM64 is 0xc0000000...
> > 
> 
> I just looked at the ABI document.
> 
> ARM has GNU_PROPERTY_AARCH64_FEATURE_1_AND 0xc0000000
> 
> X86 has:
> 	GNU_PROPERTY_X86_ISA_1_USED	0xc0000000
> 	GNU_PROPERTY_X86_ISA_1_NEEDED	0xc0000001
> 	GNU_PROPERTY_X86_FEATURE_1_AND	0xc0000002

Please add all three, not just the last one.
