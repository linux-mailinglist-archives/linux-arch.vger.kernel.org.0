Return-Path: <linux-arch+bounces-13954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B977BC52A4
	for <lists+linux-arch@lfdr.de>; Wed, 08 Oct 2025 15:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569873A3E3C
	for <lists+linux-arch@lfdr.de>; Wed,  8 Oct 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38514283C93;
	Wed,  8 Oct 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NPTt3lRa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F708255222
	for <linux-arch@vger.kernel.org>; Wed,  8 Oct 2025 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929550; cv=none; b=uPBiexYU8stRvZASfXll9kW+DIIj6D25xhNAoV9UpRA3cUpE0uTWXAW7FB5QuF09YPXNqUBVF9bBqQpCmCzCos0rnCbT86l2GKZ+sN2kd+xbpCgf/9kdzFz4JGHSOxECJ8H6x4SYdgNRfh5RyW/g/x4rkW4hJ80HFLbaF5BYtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929550; c=relaxed/simple;
	bh=MFp9KUdYt6xEG2KBVkL/DRBGqry+bbucB+9ElbhxNuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJYO6Cu7N86EzQpoMOxPyB7JaXM278eGsZTu7OuoCsnQv9gMV9uYrz8lKwG8vVtboP93E85ssIa0+L1+xVIIMLnizg66p6TII6GHLtaieX/kGk281condpZpwTRLGb20z2iYKCcRVBPkbkC3vHjxIKkBcUe8HDdCr/85u2U9tq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NPTt3lRa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so71030045e9.3
        for <linux-arch@vger.kernel.org>; Wed, 08 Oct 2025 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759929546; x=1760534346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jozU4MCtlsfVf9HK2ileSJtZZH6tHRFGD8OutqReHLk=;
        b=NPTt3lRaVKHqE5xh2rBbCkXQByy+0thnAN0grg/XTTIi8YM9OzUKCEhjXpdlx2xM3l
         eQqnmDPVeI+sw1ERUJ8OtD2G8MsDei1stRSCyFnZXtebkVKt/hvTVZKOSI0bK8XupgSu
         q32aBcW4QbEYMu9mCv2GYYoSWLs/gvgx1uDmHfkeoeAUVNErGuadNoGuJyPqmBBhvyrw
         r63Jt4XvukLbc8jDbfOhkra5WzYyhNTtctxuUuTxgMtA3Eo+cHCUzQOKqxPQL9bRx8pq
         NFmP8tXBtekHA6YJwZQyTscFS8qsir5kb1j8UwfIfz5FtS2Wk6fem2s9AMqKWxrGvol9
         usYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929546; x=1760534346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jozU4MCtlsfVf9HK2ileSJtZZH6tHRFGD8OutqReHLk=;
        b=URsBoQzCIVcrSvWKrykclgNIe9FFcbuXsvtAvaLYnp8Kikz8mo58K5DG+LgDlk/46B
         oJUhR7emMb+61ya6SMyxwI6IGqGr9Zhv2jn10YZVDezzOeIwxgXqze4hA/LV6lhpWG40
         KvId9BUe6tfIxfSyULkFbSNNmjWdnKCn8MNY+vgTUX6AqpixJPHcnSa3iia66OnTe+ru
         +e7WkSf0HH5OqtEBDyLj8jJDoM6QyfOT0rvYq35LVWrM/TFZsaZQsdYzPlIVAqyl7JHC
         f10o6ZWQtAFw68mYyQwgHPOYG2MtvSOCzyEhFe6nPeWUzfUCXQ1sFF1EBfbnLPXl8gik
         RNNg==
X-Forwarded-Encrypted: i=1; AJvYcCXGRKh8SPb49OKMhjd6+iis4uXCZ30oDJLI6vBoM+5TUalUFp9OGedmbFeVeDcFUf9zlcpz5CGlbXGl@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyLg1kipyl235Tg7I5/rwBGKlg3FaFPPmGLmdGjE/SF5RfkHr
	s6lokFbVw2KN6aPOtfZPPGyoxwAF+o1t4hM7MhIVbb2iveoQcY59Oc0eYz1L21YZbBA=
X-Gm-Gg: ASbGncsgYLlPVOzuCcDXAyTZ0jANLUwOqR2/t+UGK55rZLwRcbBc4DZ4o9BYRWXbGP7
	POSj3NoLbmCuSjCNY+SfXKyvC2cR7KPSzlrzBOMNjgEOY2ZB2SFDUULyLXYL5TbaBBbLpOruQfr
	HYDb1RcVpRCjpc5U8/mj8dx0osSDuESxkRsBEnxFEr7v6WHaahXn7lxRJE8Xbt25QHEJjwJ8Ocb
	OSbMGrkvFKVQLsei8DoD7tvS8lbv8NscShOTzFs1onJZ2Gj8XDdD0M+Kiu94qtYEZnfE/Q+VZGj
	GXRODGHhEKdGMDr1RFj2WRmPgrBPajHn+zxaRcNamHbOVIgUonmlSEKnRQF49RShaqkT+eS8O/Y
	uqPh+pvQ9Li8Ym5YgR4k+qZT4428KRtRRiHuAd4nVeTtUvv69VfKEW1ZI6EixmUk9vR7OTA08FD
	M=
X-Google-Smtp-Source: AGHT+IEaXUHfbuYM9nod7N9dOjKMSODtcO4+dyB2TLSlYEg1pQ+Lkd4II4POhjx99lRaAkInHDE4Dg==
X-Received: by 2002:a05:6000:2dc9:b0:407:7a7:1cb6 with SMTP id ffacd0b85a97d-4266e8e637amr2098415f8f.55.1759929546358;
        Wed, 08 Oct 2025 06:19:06 -0700 (PDT)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e96e0sm29841221f8f.33.2025.10.08.06.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:19:06 -0700 (PDT)
Message-ID: <fdec30b6-e3d0-4694-ba29-3bc99960346a@suse.com>
Date: Wed, 8 Oct 2025 15:19:05 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] module loader: use kflagstab instead of *_gpl
 sections
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Nicolas Schier <nicolas.schier@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250829105418.3053274-1-sidnayyar@google.com>
 <20250829105418.3053274-5-sidnayyar@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250829105418.3053274-5-sidnayyar@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 12:54 PM, Siddharth Nayyar wrote:
> Read __kflagstab section for vmlinux and modules to determine whether
> kernel symbols are GPL only.
> 
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
> ---
> [...]
> @@ -2607,6 +2605,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>  				     sizeof(*mod->gpl_syms),
>  				     &mod->num_gpl_syms);
>  	mod->gpl_crcs = section_addr(info, "__kcrctab_gpl");
> +	mod->flagstab = section_addr(info, "__kflagstab");
>  
>  #ifdef CONFIG_CONSTRUCTORS
>  	mod->ctors = section_objs(info, ".ctors",

The module loader should always at least get through the signature and
blacklist checks without crashing due to a corrupted ELF file. After
that point, the module content is to be trusted, but we try to error out
for most issues that would cause problems later on.

For __kflagstab, I believe it would be useful to check that the section
is present to prevent the code from potentially crashing due to a NULL
dereference deep in find_exported_symbol_in_section(). You can rename
check_export_symbol_versions() to check_export_symbol_sections() and add
the following:

	if (mod->num_syms && !mod->flagstab) {
		pr_err("%s: no flags for exported symbols\n", mod->name);
		return -ENOEXEC;
	}

-- 
Thanks,
Petr

