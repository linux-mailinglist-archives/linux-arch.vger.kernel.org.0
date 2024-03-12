Return-Path: <linux-arch+bounces-2934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C893878F56
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 08:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90529282C71
	for <lists+linux-arch@lfdr.de>; Tue, 12 Mar 2024 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692169974;
	Tue, 12 Mar 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwWLgk1B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACE69970;
	Tue, 12 Mar 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230268; cv=none; b=f/nSrKyEZ9NKhwhJGNw18myNqYmetgi7y2fcIdIMWORBpB4TyXEIXn3B+r93upUvelKhejU05rM37Noh/5U722c0hfAKzPvjS6jA7TxqyMGhVLEPu4yVr8EeRWWmPhoMep4PtmDj7vYesfHgRplvHGGHFUpF7Bxean4ESnRaugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230268; c=relaxed/simple;
	bh=Yc2Zosn8hrBilQetoqRmQZabxhLsQ0b25ROIRXAX4/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJ57y+bWl/ArJBuKgpOZYps8evkEXMlALaRS2X+ke3E68bFOiorV5OtqWoLv+ItYi19rZKDoALAa3sjEslMPL/kFvBusHYVnjpMyd503ofDHKLltwUOFPC7S2/Q5mLJ3j6zPYX+oMy9GK5OqWahe8GkgCpbOXcMz7z/tLNqjzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwWLgk1B; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d3e41406e0so451219e0c.1;
        Tue, 12 Mar 2024 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710230266; x=1710835066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhEXY66RC+qpPscdSLuIpwtHRZwlPy11Ok4VW2LU5lA=;
        b=BwWLgk1BRx4BRk/6Z2i4WyjdJdj9rRo9Y6E7VO+rymIni4CPg+mCc/tEdvOoHCKF3t
         JkXee0BnF89s4DDGpoQZeyeRsJy5jwsSXS3bb/9USXrUqjy9WbzvDLmiunDzFPuE4kP4
         MR8cLHId8ZI6T+EfdhjjuPE2RoXheRahqBkM7rWSxWJ10SsLMVQIxwHsrG5qZaWy710j
         +QwB18NF3wGOsjLdv0JHRmrCi7o+f9K6Jk+vmaIUE6cz9JgKjKzgkHzh905tfgSSg4At
         4PAb0kwDnVQXtSr2+mC5Mpybkr6gVoOheeXYc2Oeg9hWL4VR56az4k8Yhfc/ALycnEc5
         JPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710230266; x=1710835066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhEXY66RC+qpPscdSLuIpwtHRZwlPy11Ok4VW2LU5lA=;
        b=k9lxVHMmcqvbnJZpT5cMusGCjof6b90jO22jRL7WUMs6hOaSJQaN8gOzfAw6RP3dH9
         JuOY3wK4VpgNBIT8fUbPZAvZRi+dejw5lM9T+HaGc6Yh8viKEPlZDtpSm4XUJ3ccwyJc
         uV1+QSX+/cgVXqidcZGdkcmJMRvn5UJavSbuUrt+GNl8X/y2KdbBy2693O43exn4aSKN
         goNNXH0sN3nhUrDKsROcbTSLZIP+UI78dR4+7Vy7HJQCYfq2HbM66TuBD9CajjXuIfMn
         dLga2bWX0saTdfEJIhvuCGGcHUIS9A5ZsCRJRAyW+9lOC+NI5/juII/zY/jIeKnkjlUR
         TVjw==
X-Forwarded-Encrypted: i=1; AJvYcCVqc4kfVx1mnRdGNTC1iJjOKnYnDIHxL7jaw8GOzpQfiSYQc3N3hK9LNoMYnKuQV//MBde8OV+WcoUn/hJjwc6pna5n0Cc/mdiu/9X+L9FTDRinzJf0DM7ROKUmxdqVxqWYybq5yjud8A==
X-Gm-Message-State: AOJu0Yz28UhS8HO1uTw1Tjwhet/36Gjaq6sbh5r3jmJouBeLMAFN+qE8
	QbPZynlUKwE7V9OKP0/ZCvlEbct7ecN6E7VdQdkg2bF/V+HyiCHHJKJvkjBfKh7emjnxG0YntIW
	JO1coqnQhGEG0bkdzgw2IN4XYYXE=
X-Google-Smtp-Source: AGHT+IHhNzjV5+ACB49bOdzufQIaNot/JxcWClw8dMJWp4LtF4ooQ29vn4L65o1P0dgSsEWIy+Qf7hhJy2SbOZZg72g=
X-Received: by 2002:a05:6122:1dab:b0:4d3:3b1b:aa92 with SMTP id
 gg43-20020a0561221dab00b004d33b1baa92mr5627133vkb.11.1710230265598; Tue, 12
 Mar 2024 00:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312073131.2278318-1-chenhuacai@loongson.cn>
In-Reply-To: <20240312073131.2278318-1-chenhuacai@loongson.cn>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 12 Mar 2024 20:57:34 +1300
Message-ID: <CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove superfluous flush_dcache_page() definition
To: Huacai Chen <chenhuacai@loongson.cn>, chris@zankel.net, 
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	loongson-kernel@lists.loongnix.cn, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 8:31=E2=80=AFPM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> LoongArch doesn't have cache aliases, so flush_dcache_page() is a no-op.
> There is a generic implementation for this case in include/asm-generic/
> cacheflush.h. So remove the superfluous flush_dcache_page() definition,
> which also silences such build warnings:
>
>    In file included from crypto/scompress.c:12:
>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but n=
ot used [-Wunused-but-set-variable]
>       76 |                 struct page *page;
>          |                              ^~~~
>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> >> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunus=
ed-variable]
>      174 |                         struct page *dst_page =3D sg_page(req-=
>dst);
>          |
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@i=
ntel.com/
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---

Thanks, Huacai!

Acked-by: Barry Song <baohua@kernel.org>

+Chris, Max

And I find arch/xtensa/include/asm/cacheflush.h also
needs a similar fix.

>  arch/loongarch/include/asm/cacheflush.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/inc=
lude/asm/cacheflush.h
> index 80bd74106985..f8754d08a31a 100644
> --- a/arch/loongarch/include/asm/cacheflush.h
> +++ b/arch/loongarch/include/asm/cacheflush.h
> @@ -37,8 +37,6 @@ void local_flush_icache_range(unsigned long start, unsi=
gned long end);
>  #define flush_icache_range     local_flush_icache_range
>  #define flush_icache_user_range        local_flush_icache_range
>
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
> -
>  #define flush_cache_all()                              do { } while (0)
>  #define flush_cache_mm(mm)                             do { } while (0)
>  #define flush_cache_dup_mm(mm)                         do { } while (0)
> @@ -47,7 +45,6 @@ void local_flush_icache_range(unsigned long start, unsi=
gned long end);
>  #define flush_cache_vmap(start, end)                   do { } while (0)
>  #define flush_cache_vunmap(start, end)                 do { } while (0)
>  #define flush_icache_user_page(vma, page, addr, len)   do { } while (0)
> -#define flush_dcache_page(page)                                do { } wh=
ile (0)
>  #define flush_dcache_mmap_lock(mapping)                        do { } wh=
ile (0)
>  #define flush_dcache_mmap_unlock(mapping)              do { } while (0)
>
> --
> 2.43.0
>

