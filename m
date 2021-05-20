Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2238B544
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 19:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhETRgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhETRgi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 May 2021 13:36:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D263C061574;
        Thu, 20 May 2021 10:35:16 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0eb6009f35b1f88a592069.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:b600:9f35:b1f8:8a59:2069])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B117E1EC064A;
        Thu, 20 May 2021 19:35:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621532114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jyeifkyUkzNG31NMoAeYuHXzsVHM1PiLeXM0YrStR4Q=;
        b=NucfAkSU9ufdbQm5qK/YeQd8Jl1FGqkuCwHsSaRjJnCe+lgqpxHmkmPz7v7+bxDDUl+MfC
        75mf30AIjwtrGPllOs4ayJhTJygkTk008KfwZmTVsYyQoSMRy9j6uTSo+77xqnxyi+ypSz
        Ar9VaAYzoQRDrfTCws6GgJ6YKfmd100=
Date:   Thu, 20 May 2021 19:35:13 +0200
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
Message-ID: <YKad0e5VDNZhBw+4@zn.tnic>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
 <20210427204315.24153-27-yu-cheng.yu@intel.com>
 <YKVUgzJ0MVNBgjDd@zn.tnic>
 <c29348d8-caae-5226-d095-ae3992d88338@intel.com>
 <YKYrQQ6tKfifjNjW@zn.tnic>
 <d04259f1-a869-ec1c-aa74-93cd6c2c2d7b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d04259f1-a869-ec1c-aa74-93cd6c2c2d7b@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 20, 2021 at 10:18:10AM -0700, Yu, Yu-cheng wrote:
> The latest pdf's are posted here.
>
> https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI

Ah, that document.

Please make sure it is specified over those defines from which document
they're coming from.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
