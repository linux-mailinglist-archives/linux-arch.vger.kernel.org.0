Return-Path: <linux-arch+bounces-4553-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3428D176D
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 11:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2921B22ECA
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0B416A39D;
	Tue, 28 May 2024 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlSLy4w8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B14F169AC9;
	Tue, 28 May 2024 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889363; cv=none; b=Nk9du9jvWARmp9D1JDOVO9J/5cCOsb0mGtZq/9+9WCpmi6A/WRM+KNApyOLGxpX+20Uo4vnHbg61iINew3YUkEpiAFcTHh87y8dklJHxbDSTLN2xpzls2lTJsL0HADsa6nYTsKpl+D8hPVgMJ2NYTFvJoF3EDVYfsndtOkIoaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889363; c=relaxed/simple;
	bh=qfLyJtmax/jZ+eAaCvC7e67XX9TGTXKhgERpUQNkjH8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DsS8w4vl4LH5+fODbiMNUZj5rg5OWMUFzuu3YgtGW6rhvQrSohruM55E0H5QFmR4sMKXZ0F+IAJh5X3x5p42qsZptj5Q/cUiRiWI20gf0kEnkmY7ipSyWiaKLUWcVknR0olOdUNQw1wD8TTIWw7PaNKzY2+EMj5XtclgQZpxa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlSLy4w8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52389c1308dso785920e87.3;
        Tue, 28 May 2024 02:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716889359; x=1717494159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGOI2J3FbR+ob+LmVGOsGjzCJpew9van2Zh3gScMtnI=;
        b=PlSLy4w8caOEn8GkGAMk9ozPxv4rZ/aqpyRuFpOW1tGLO2gwptft0fWg/FY/io3fmL
         sxb5lDOss3SGQSZNKe9MtgfojgSfZBsEbeusMCr3FNxR6S57Aw7fjX74yosxPK9UceRk
         lS80zblMNqHISaRd1UHocxZfPn49JS07AcjMxtR4Ehn2Xqtu+ZF12cTJNJy4aa+7uc8d
         qaoPLXXKgkXQC3Ef/o6Qau7GXuTBeDIiOn6LN5UgDfmuUrmy9MPTvzY3KrFrk5mlWCZr
         lWFFOvt1bh37zlOdyfN3yfDVi7KDaK583eunL1BjyLhoo1D17sK7sOalrM1O1Fr/KsAG
         7BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889359; x=1717494159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGOI2J3FbR+ob+LmVGOsGjzCJpew9van2Zh3gScMtnI=;
        b=nxq38ZWTJTRqGf6xUXe7CQNf8VXG55VlIqzx7UqPI6XvGsffNqx2UIebqM61fxXjhz
         qYjwpVsJw0MeQxJ6ECHy24a7pAAlhIdh3PaUlgKLVaHrta/MLf8SpvzmLGNSAUNEkjZL
         iM3QEIp4Na8mFuRXw80/KUrrVlkx4HPwkT2xzus8rl1QCZtzbGb2sPC/n06/U8RXuRUr
         Gx50yPmyh/k2nWc81SFJd6y0MQ6xO5bwrDDkMPzanosf4rmluAU1XP3AeEmAtfLYtycV
         isOS7Hw44ex+fWDJU9dJjm617wF+Cp8zx1zeQ/1wMPrIVKiNfstm49Z1ImXVRZtg4fXi
         Wcgw==
X-Forwarded-Encrypted: i=1; AJvYcCV2rbpDeAYwynGDrNKLShGLQ91q7h4Ostw/rd47VTIJpG4MrvaLo/q0AuKhjbwXvOCEOA+51oQYFPS0Xq6CptTyK2gGEimnLEFryGn7997Sdd7G0r1cTKjlNY1x2gHlda04wRKpAIHis/8qXnps5aJeRQQ0H6qAS/2kc/qfaw==
X-Gm-Message-State: AOJu0Yxzn7EprNu/qe4Q1tV1k9mngf7Pk7dkWbp/CSZ6Pkgvyr4Wxhxz
	NFxNLN/y+XGiZpwUrhqJnTsQYDkQKs9EKbItS703lnNdQiyzRpgM
X-Google-Smtp-Source: AGHT+IFlYhYgNNNQ1wITN1+9f9HdlVJxGanJiZQ7t7o1+FR679Fx/NlkuEWMH/d5GYnhY4Rz+401iA==
X-Received: by 2002:a05:6512:2396:b0:51a:f596:9d53 with SMTP id 2adb3069b0e04-529664dad37mr9975256e87.42.1716889359003;
        Tue, 28 May 2024 02:42:39 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fd37f19fsm130468165e9.1.2024.05.28.02.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:42:38 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 28 May 2024 11:42:37 +0200
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] kbuild: remove PROVIDE() and refactor vmlinux_link
 steps
Message-ID: <ZlWnDT1S7n4XrAb5@krava>
References: <20240522114755.318238-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522114755.318238-1-masahiroy@kernel.org>

On Wed, May 22, 2024 at 08:47:52PM +0900, Masahiro Yamada wrote:
> 
>  - Remove PROVIDE() in the linker script
>  - Merge temporary vmlinux link steps for BTF and kallsyms
> 
> 
> 
> Masahiro Yamada (3):
>   kbuild: refactor variables in scripts/link-vmlinux.sh
>   kbuild: remove PROVIDE() for kallsyms symbols
>   kbuild: merge temp vmlinux for CONFIG_DEBUG_INFO_BTF and
>     CONFIG_KALLSYMS

lgtm, fyi I ran bpf CI on top of this change and passed

https://github.com/kernel-patches/bpf/pull/7104

jirka

> 
>  include/asm-generic/vmlinux.lds.h | 19 -------
>  kernel/kallsyms_internal.h        |  5 --
>  scripts/kallsyms.c                |  6 ---
>  scripts/link-vmlinux.sh           | 87 ++++++++++++++++---------------
>  4 files changed, 45 insertions(+), 72 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

