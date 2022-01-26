Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2A049D496
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jan 2022 22:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiAZVg3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jan 2022 16:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiAZVg2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jan 2022 16:36:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0C9C06161C;
        Wed, 26 Jan 2022 13:36:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C190DB82022;
        Wed, 26 Jan 2022 21:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F23C340E8;
        Wed, 26 Jan 2022 21:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643232984;
        bh=qiDwOHAZZYgzMESTLY09sncGjaRqe3P7WUyD63U80QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5N5X4tFYnAPtsQXZdHMR/zZCc9G6WRuaXBfK+Ty5IM/QMwMOdyliX4LBQzikYCRA
         EbxPUMzlBLq5kxn2Lp0cw6skBSXxq8XEgVuf6+lujnGG1XDj3L51N6//5M6Y3QrjOh
         Qjjsvo6HAyuhIFv50e2OCI+NPAASzuQaMml82XCScDEM2tNfWJ8JjwQ0gEcih7/MNY
         JNESyI5BmHohYobkVSEHNReqMQ9KBlDKprBjI8o+gcDWHjkFEduTZaWXpcnWDLvcXp
         mXoALrN0E1bm7oyRxjSzeBe/lgpnyZM+LvvX9slVLLDeANjKEhkqhZJe9x6IunDd7F
         UbXGnOxc8kq6g==
Date:   Wed, 26 Jan 2022 23:36:13 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Message-ID: <YfG+zVl8aV+UszoE@kernel.org>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 24, 2022 at 09:22:15AM +0000, Christophe Leroy wrote:
> within_module_core() and within_module_init() are doing the exact same
> test, one on core_layout, the second on init_layout.
> 
> In preparation of increasing the complexity of that verification,
> refactor it into a single function called within_module_layout().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/module.h | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index c9f1200b2312..33b4db8f5ca5 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -565,18 +565,27 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr);
>  bool is_module_percpu_address(unsigned long addr);
>  bool is_module_text_address(unsigned long addr);
>  
> +static inline bool within_range(unsigned long addr, void *base, unsigned int size)
> +{
> +	return addr >= (unsigned long)base && addr < (unsigned long)base + size;
> +}

There's also 'within' at least in arch/x86/mm/pat/set_memory.c and surely
tons of open-coded "address within" code.

Should it live in, say, include/linux/range.h?

> +
> +static inline bool within_module_layout(unsigned long addr,
> +					const struct module_layout *layout)
> +{
> +	return within_range(addr, layout->base, layout->size);
> +}
> +
>  static inline bool within_module_core(unsigned long addr,
>  				      const struct module *mod)
>  {
> -	return (unsigned long)mod->core_layout.base <= addr &&
> -	       addr < (unsigned long)mod->core_layout.base + mod->core_layout.size;
> +	return within_module_layout(addr, &mod->core_layout);
>  }
>  
>  static inline bool within_module_init(unsigned long addr,
>  				      const struct module *mod)
>  {
> -	return (unsigned long)mod->init_layout.base <= addr &&
> -	       addr < (unsigned long)mod->init_layout.base + mod->init_layout.size;
> +	return within_module_layout(addr, &mod->init_layout);
>  }
>  
>  static inline bool within_module(unsigned long addr, const struct module *mod)
> -- 
> 2.33.1
> 

-- 
Sincerely yours,
Mike.
