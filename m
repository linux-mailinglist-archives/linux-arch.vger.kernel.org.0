Return-Path: <linux-arch+bounces-3472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D67B89A188
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBC71C20821
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5F316F919;
	Fri,  5 Apr 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrbi3bY6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A501DFE4;
	Fri,  5 Apr 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331677; cv=none; b=JHP+3zWJ2nzeQZAXmGpuQvNT32eebRUrCMySdeEQwx/EEDDAwiUdJvd6olUzxlsSNpD30G3JV4ndcMTZFLNOmrNKQLsGECCQVWbc2Jy0EngSqS+NTgQ6/UTMIxHUXdfM9MyH8lKL2/PY55GUi97nOAbywtlboyuAQNRACaXKcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331677; c=relaxed/simple;
	bh=rZJGyKNtzoutcmvD9yBAQBRLOt5WkG7MywHLVvMRWZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1U25hQPW7/iEgBTPtKJl0Pwx6+vJJfyPr2l0HHxlDOKrJ/irLWSyiljqZNkXgO3SvlMRwu1txNMHVt8MnxAZLK1/Vdi33g/IKno/zyPeNa9SbGeRzVfsLOGF6llGqDk9Z9vENwGMTzHYt7qRfBoQC9S3/hELWFtaZIhujcLT98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrbi3bY6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4163181a7ceso4796085e9.0;
        Fri, 05 Apr 2024 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712331674; x=1712936474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWae/TQVR4lDMRxTHKpFB8Vkf/PIFo/hlHy1KJVttno=;
        b=Zrbi3bY6TWu8nzzhcBUiUS9i51HQAy+PP8m+ions/eaLgCT2afnymTyF6ZPX2L5jj0
         O2QUpcQZOZhGVF33VidqinJidL9dDTLqFjp49lcpGxmx5OcoEqDhkSY+0IjFB1SuAZbn
         vbuwk/TXT/DXX0SkoqZhQQFJC1l58Y1LpCxn9bh1ofqHrp47m4toz847at/FEXioKin9
         mGHqBf7upSb3L5vCOPZHVXtjooiQe5+C2TsZgmVzUIPuHdu1SYdbo5JG9mDLDzu8m60v
         DFDoYqFODUUXR4MWq/T2ZklzdBF4qVWsWUdJJUxs7j2eMPBCOtx7olJcQpfWG+aTXpbC
         Y9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331674; x=1712936474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWae/TQVR4lDMRxTHKpFB8Vkf/PIFo/hlHy1KJVttno=;
        b=V75OqEkMGHuO5XVOOCwDm+4cIjcenJ1nPTCI9ZnLXWPZrXneHknzLZTYWlyi8dNPGD
         nKRepRjtonTaLSfrbp4eALSXjg4n07U8Z4Aem9LY7fcZAFO54Gq80i4zpDM56jDjSZOV
         mcLy+0G6sUnkfPSVvKXoS0/4KobrsRT4V6nevsufh3/rZRGeZmr9pUzK1Xf++w1LuyZO
         pHT88Znvf8xOeVB/SPhpt5AsN8JdOBAqu3/cV74g9JBU2KYEUsQuDQPoGi27Qz4GTAQ5
         Rs7CLY14RzHQDRCf6fxsO+PqvJnAdWkXT6kDVMUP87t93Pj3Gjk8lD76ddv4hIEZ8jED
         +Rxw==
X-Forwarded-Encrypted: i=1; AJvYcCX87hIdpjqcDNB/8KoGLWp571LT54RgXumry5CJI9sfUglLdNSHYiJqA3qAfYpyySN6pIHbchSvu8zwqD+LXCyfuaBlik6TyoJRRgwz/fGrmN8d9704Q8PlfTpmJxcHBVI5Utox8cJFy69vcCLVQPFbHoKMYFD30w+op1m0Jg9izaX+umoxh09+qycKTKXZZy5JNTuOdy/+ikyGrzfGZWlfzbQ11eVtXlhPp/qmuiXp7z/A5TQfzNUgyb1YxyMYNdt3WpPRPl494mhZCvTWF6UfjBBH8d3nCKbj45LhlxOkJe6S6QwsogXegaHvwJaRkr9QuIc=
X-Gm-Message-State: AOJu0YzGFCrTxq/voXaZURL2XeOsNKwiwup2aFnrQvotGneJ5wkuJfQ7
	vH16VVKnVivchoc0yFchZtCMZoSu+8KNeDLkxLpU0RlVoJNCkAuns24H+e5XnzyO+futuy3jq1X
	qs2BHpd7Vj7VhoPLQ6hR2GMklOEfjpfcMYYc=
X-Google-Smtp-Source: AGHT+IEH9WiGdwQmFDR3UUpRkcaEXiGYsc+rbm05qeGkTnAd0VuAIEH5g2EodOENEkeRm+TdhthkOlf3f027HucPkCY=
X-Received: by 2002:a05:600c:19cd:b0:416:2bef:ce81 with SMTP id
 u13-20020a05600c19cd00b004162befce81mr1484706wmq.1.1712331657141; Fri, 05 Apr
 2024 08:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404052349.lQch9J7G-lkp@intel.com>
In-Reply-To: <202404052349.lQch9J7G-lkp@intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Apr 2024 08:40:45 -0700
Message-ID: <CAADnVQJXq1bSe20FgBN=BL1E5d8qOfLv_Ettq+724h5QfRuuKg@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	bpf <bpf@vger.kernel.org>, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arch <linux-arch@vger.kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 8:37=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-n=
ext.git master
> branch HEAD: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc  Add linux-next spe=
cific files for 20240405
>
> Error/Warning reports:
>
> https://lore.kernel.org/oe-kbuild-all/202404051333.7und7PPW-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202404051423.eiaXLwhX-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202404051659.aawUkGUQ-lkp@intel.com
> https://lore.kernel.org/oe-kbuild-all/202404052022.Cwf2ilBp-lkp@intel.com
>
> Error/Warning: (recently discovered and may have been fixed)
>
> aarch64-linux-ld: kernel/bpf/verifier.c:20223:(.text+0xdbb4): undefined r=
eference to `__SCK__perf_snapshot_branch_stack'
> aarch64-linux-ld: verifier.c:(.text+0x17c3c): undefined reference to `__S=
CK__perf_snapshot_branch_stack'
> drivers/i2c/busses/i2c-i801.c:1407:(.text+0x1d2ef4a): undefined reference=
 to `i2c_root_adapter'
> kernel/bpf/verifier.c:20223:(.text+0xdba4): dangerous relocation: unsuppo=
rted relocation
> loongarch64-linux-ld: kernel/bpf/verifier.c:20223:(.text+0xa818): undefin=
ed reference to `__SCK__perf_snapshot_branch_stack'
> loongarch64-linux-ld: verifier.c:(.text+0xa964): undefined reference to `=
__SCK__perf_snapshot_branch_stack'
> mips64el-linux-ld: verifier.c:(.text.do_misc_fixups+0xd9c): undefined ref=
erence to `__SCK__perf_snapshot_branch_stack'
> riscv32-linux-ld: section .data LMA [00369000,00907967] overlaps section =
.text LMA [0007899c,01a6a6af]
> s390-linux-ld: verifier.c:(.text+0x13038): undefined reference to `__SCK_=
_perf_snapshot_branch_stack'
> verifier.c:(.text+0x17c14): relocation truncated to fit: R_AARCH64_ADR_PR=
EL_PG_HI21 against undefined symbol `__SCK__perf_snapshot_branch_stack'
> verifier.c:(.text+0xa960): undefined reference to `__SCK__perf_snapshot_b=
ranch_stack'
> verifier.c:(.text+0xadd0): dangerous relocation: unsupported relocation
> verifier.c:(.text.do_misc_fixups+0xd98): undefined reference to `__SCK__p=
erf_snapshot_branch_stack'

Fixed in bpf-next with commit:
https://lore.kernel.org/all/20240405142637.577046-1-arnd@kernel.org/

