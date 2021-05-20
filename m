Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4738A12E
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhETJ27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 05:28:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231811AbhETJ1t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 May 2021 05:27:49 -0400
Received: from zn.tnic (p200300ec2f0eb6008eba81a1ad09a99c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b600:8eba:81a1:ad09:a99c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4721A1EC051F;
        Thu, 20 May 2021 11:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621502786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sBPCBfFxpVVzA8qvfueuilIPqhAowYTHXr3cnG4eLoI=;
        b=Ps5CMwItn7MpMTJ7xjmt5Te7zi7KyKAeJu1+YnmeLarTJdGGkhGNyRrYiLuMWqemQBxvJk
        anKV0jiMn14lqWauALXkE4RwiiUPsYosxjjwmgqbyTltUkyT44O2vOA8LqAg/+ijlDlpav
        xmBC5chCNww4ZWjVHkkaXZJu2/rHo+4=
Date:   Thu, 20 May 2021 11:26:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Message-ID: <YKYrQQ6tKfifjNjW@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-27-yu-cheng.yu@intel.com>
 <YKVUgzJ0MVNBgjDd@zn.tnic>
 <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 03:14:58PM -0700, Yu, Yu-cheng wrote:
> However, those parsing functions take (struct arch_elf_state *) as an input.

Exactly.

> It probably makes sense to have ARCH_USE_GNU_PROPERTY dependent on
> ARCH_BINFMT_ELF_STATE.  It would be ok as-is too.  ARM people might have
> other plans in mind.

Well, let's look at ARM, ARM64 in particular. They have defined struct
arch_elf_state without the ifdeffery in

arch/arm64/include/asm/elf.h

and are using that struct in arch_parse_elf_property().

And they have selected ARCH_BINFMT_ELF_STATE just so that they disable
those dummy accessors in fs/binfmt_elf.c

And you're practically glueing together ARCH_BINFMT_ELF_STATE and
ARCH_USE_GNU_PROPERTY. However, all the functionality is for adding
the gnu property note so I think you should select both but only use
ARCH_USE_GNU_PROPERTY in all the ifdeffery in your patch to at least
have this as simple as possible.

> I just looked at the ABI document.

Which document is that? Link?

> ARM has GNU_PROPERTY_AARCH64_FEATURE_1_AND 0xc0000000
> 
> X86 has:
> 	GNU_PROPERTY_X86_ISA_1_USED	0xc0000000
> 	GNU_PROPERTY_X86_ISA_1_NEEDED	0xc0000001
> 	GNU_PROPERTY_X86_FEATURE_1_AND	0xc0000002

Our defines should at least have a comment pointing to that document.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
