Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE68F38FF92
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 12:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhEYKzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 06:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229790AbhEYKzv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 06:55:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 455B66142D;
        Tue, 25 May 2021 10:54:17 +0000 (UTC)
Date:   Tue, 25 May 2021 11:54:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
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
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v27 27/31] ELF: Introduce arch_setup_elf_property()
Message-ID: <20210525105414.GC15564@arm.com>
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
 <20210521221211.29077-28-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521221211.29077-28-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 03:12:07PM -0700, Yu-cheng Yu wrote:
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 8d1c8dcb87fd..d37bc7915935 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -281,6 +281,11 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
>  	return 0;
>  }
>  
> +static inline int arch_setup_elf_property(struct arch_elf_state *arch)
> +{
> +	return 0;
> +}

For the arm64 addition:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
