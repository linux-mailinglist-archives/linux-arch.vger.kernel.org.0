Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B40790E8A
	for <lists+linux-arch@lfdr.de>; Sun,  3 Sep 2023 23:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjICVsl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 3 Sep 2023 17:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjICVsk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Sep 2023 17:48:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A641E5;
        Sun,  3 Sep 2023 14:48:37 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso9373965e9.3;
        Sun, 03 Sep 2023 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693777715; x=1694382515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G6PzTqKpNLFrONgI2DvDeDfRk/tu5M/iWei//8Yr/k=;
        b=dz76MplYhPaIoGG4RwdeFBIDdStWQvr19zJAiv+FNGEpKZso9QpNSQBZVVcKu1hUih
         YVy1YWcN9BZZz1YvtZFr5/dl+M/B9Ukr55Cl5MvUkqncaJeBclWrBOsdI0ia40m/tU/h
         zaNgM8n6R+U8J2gbhiDLYLL+zfZmVSmFHo9BEZL5flmzJFj263xV2Sx0LRLKq4dEGJqL
         CoeXHkq4GUIvlnFPXhro1NIDytgp48l3SS8sYSNxhTeQ6DwwHJkc0VBpptkLKZnoaGcj
         vuIg1kXOMSRSCKXReHIeJbWdsQCmTzD+IjDDwpBhwwfQ9Mqa2h5LWMHqO92NeWeywHJf
         LRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693777715; x=1694382515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G6PzTqKpNLFrONgI2DvDeDfRk/tu5M/iWei//8Yr/k=;
        b=XC39Wq0KCTEH8BKAR5XDEsPNaBdYvKUa2fJMzIgBCQisXtKU4UOq7zgLGUoNVJnyqB
         Q9A+f6pWAH+c5AJIDmsYBWsp4IQ5kuDARi3ddKfgXhnsOdKj+2rftoMDSHkVn/wGE/G+
         LOXwXEBDbG94Bx5+qxDg1QBRSMDUzPqQZnGUaSk85kXcZC58oqI/1hx7AKcgPL2gTEjW
         j+bJk7LqDsnlYWew1kaqirB3s7Jh+afPgDEe8mthAxTj0X2L6h5EHI4op6N9vvLrXiKv
         IMPq8rMRurMGYUosV1AdhibpC6L58G+Z/VbK21vtg7kWpThpEd23nkKWgF/U+RMZxnxO
         CwLQ==
X-Gm-Message-State: AOJu0YyMbSLoojYBfpFP9puFeK4SliT8Nlwadduqkul5Fi/2hpMX86fk
        DxKNXnc8kmxoKAgmBp0jVb4=
X-Google-Smtp-Source: AGHT+IFEX8LBvprib4Dtt+mBP6ObEn4kwFaRCA1kaqIKemZ3oMTfqRgpNzBp1CSnuYTTwf1PpfSXdg==
X-Received: by 2002:a05:600c:21c1:b0:3fe:1871:1826 with SMTP id x1-20020a05600c21c100b003fe18711826mr5685808wmj.27.1693777715336;
        Sun, 03 Sep 2023 14:48:35 -0700 (PDT)
Received: from gmail.com (1F2EF6A2.nat.pool.telekom.hu. [31.46.246.162])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bcd09000000b003fe0a0e03fcsm15148170wmj.12.2023.09.03.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 14:48:33 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 3 Sep 2023 23:48:31 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
Message-ID: <ZPT/LzkPR/jaiaDb@gmail.com>
References: <20230830140315.2666490-1-mjguzik@gmail.com>
 <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f>
 <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 3 Sept 2023 at 13:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > "real fstat" is syscall(5, fd, &sb).
> >
> > Sapphire Rapids, will-it-scale, ops/s
> >
> > stock fstat     5088199
> > patched fstat   7625244 (+49%)
> > real fstat      8540383 (+67% / +12%)
> >
> > It dodges lockref et al, but it does not dodge SMAP which accounts for
> > the difference.
> 
> Side note, since I was looking at this, I hacked up a quick way for
> architectures to do their own optimized cp_new_stat() that avoids the
> double-buffering.
> 
> Sadly it *is* architecture-specific due to padding and
> architecture-specific field sizes (and thus EOVERFLOW rules), but it
> is what it is.
> 
> I don't know how much it matters, but it might make a difference. And
> 'stat()' is most certainly worth optimizing for, even if glibc has
> made our life more difficult.
> 
> Want to try out another entirely untested patch? Attached.
> 
>                 Linus

>  arch/x86/kernel/sys_x86_64.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/stat.c                    |  2 +-
>  include/linux/stat.h         |  2 ++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
> index c783aeb37dce..fca647f61bc1 100644
> --- a/arch/x86/kernel/sys_x86_64.c
> +++ b/arch/x86/kernel/sys_x86_64.c
> @@ -22,6 +22,50 @@
>  #include <asm/elf.h>
>  #include <asm/ia32.h>
>  
> +int cp_new_stat(struct kstat *stat, struct stat __user *ubuf)
> +{
> +	typeof(ubuf->st_uid) uid;
> +	typeof(ubuf->st_gid) gid;
> +	typeof(ubuf->st_dev) dev = new_encode_dev(stat->dev);
> +	typeof(ubuf->st_rdev) rdev = new_encode_dev(stat->rdev);
> +
> +	SET_UID(uid, from_kuid_munged(current_user_ns(), stat->uid));
> +	SET_GID(gid, from_kgid_munged(current_user_ns(), stat->gid));
> +
> +	if (!user_write_access_begin(ubuf, sizeof(struct stat)))
> +		return -EFAULT;
> +
> +	unsafe_put_user(dev,			&ubuf->st_dev,		Efault);
> +	unsafe_put_user(stat->ino,		&ubuf->st_ino,		Efault);
> +	unsafe_put_user(stat->nlink,		&ubuf->st_nlink,	Efault);
> +
> +	unsafe_put_user(stat->mode,		&ubuf->st_mode,		Efault);
> +	unsafe_put_user(uid,			&ubuf->st_uid,		Efault);
> +	unsafe_put_user(gid,			&ubuf->st_gid,		Efault);
> +	unsafe_put_user(0,			&ubuf->__pad0,		Efault);
> +	unsafe_put_user(rdev,			&ubuf->st_rdev,		Efault);
> +	unsafe_put_user(stat->size,		&ubuf->st_size,		Efault);
> +	unsafe_put_user(stat->blksize,		&ubuf->st_blksize,	Efault);
> +	unsafe_put_user(stat->blocks,		&ubuf->st_blocks,	Efault);
> +
> +	unsafe_put_user(stat->atime.tv_sec,	&ubuf->st_atime,	Efault);
> +	unsafe_put_user(stat->atime.tv_nsec,	&ubuf->st_atime_nsec,	Efault);
> +	unsafe_put_user(stat->mtime.tv_sec,	&ubuf->st_mtime,	Efault);
> +	unsafe_put_user(stat->mtime.tv_nsec,	&ubuf->st_mtime_nsec,	Efault);
> +	unsafe_put_user(stat->ctime.tv_sec,	&ubuf->st_ctime,	Efault);
> +	unsafe_put_user(stat->ctime.tv_nsec,	&ubuf->st_ctime_nsec,	Efault);
> +	unsafe_put_user(0,			&ubuf->__unused[0],	Efault);
> +	unsafe_put_user(0,			&ubuf->__unused[1],	Efault);
> +	unsafe_put_user(0,			&ubuf->__unused[2],	Efault);

/me performs happy dance at seeing proper use of vertical alignment in 
bulk-assignments.

If measurements support it then this looks like a nice optimization.

Thanks,

	Ingo
