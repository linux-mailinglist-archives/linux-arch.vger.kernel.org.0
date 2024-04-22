Return-Path: <linux-arch+bounces-3866-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 797908AC8A6
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58BB1F247B1
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B767852F96;
	Mon, 22 Apr 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="RDqBOJtW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA022611
	for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777333; cv=none; b=XSsNK98m2a36TLx0aipDZayeqMZyahvHv3eovRJhaVCzn0y3++jYGWtvLRCyMxnOHatLNNMScTqpvSYDwDG681g1pxCI3U8vN1TH4kL4ADfkzF5ko+s+TUEZwEKnWJ4FpZnr+rqMnIZ29meOhnsDP9lgQVGRtC9XgcAdd/ZsWug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777333; c=relaxed/simple;
	bh=b/wu88jA9YdxZN0vncf57S6bbFuU12MW/xuCRw6CPIc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BF9CrdF8KJTESys/qwIacht9GBGadeL2h8VY0PANT2/atldIviMRPhdKuAaVbxdvv838looIa2/0jWK1yJyMtpNxj746j0HjnUhylboPK8mgIarxPAned6X73ZLJ+GhYS8FNsVNLZ8kJTCVYr1t5JRaBY7Sj28rTwiw7yBz7gBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=RDqBOJtW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso6314702a12.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Apr 2024 02:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713777330; x=1714382130; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/wu88jA9YdxZN0vncf57S6bbFuU12MW/xuCRw6CPIc=;
        b=RDqBOJtWr2Pk57ZFfNBWbGabCvsULDnIVFKz8TBjvCza5XhRAhTKRPgVYfDKuVmw7+
         d8GIePLCp8VIUmk52U2gCUf6BP8Po0KkEPogiy9+0AreI3r0DE7dJjtMFvEjD1tAZsZQ
         5fYkjW8XR2sLJNCRj6glJJ3Crut7rGUc4FefaHVCqME2uSnraPVGUjdkwm+66il7UZL8
         U7DmsyU1dl2lY9jpYuDux9eC88IcIOzGmZ0+ViVuOfk+wKbQE0Owbc6V1Oa2uFW4EqDB
         Ldz8p1VMyXb2b7pnDsnq7dCY88JOfe+wsSGxz8B0EYBy1X+zj13XiTNHdHud1pYT2XDR
         e4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713777330; x=1714382130;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/wu88jA9YdxZN0vncf57S6bbFuU12MW/xuCRw6CPIc=;
        b=WwHCeWZKW/TX3iVp0gK6S8epcxzQI0s0aYddhl2xtMRU99JXT476sbn4/XsbUOUpLO
         o1+eD5RbPHSr/4aGWeAieBUxdKFAubnkJjz9s4x+9t6u4L13thoWlkL/kQx9FVtj1bez
         fwMRofm4oi6Rblpchdvb2W9LocVuqqy9nPkeoxJnAYfTvMt2A4ELGev0gsi6O7NIADha
         ltJayuXewLX6PiavjoNQtve94lBvlyNND1k2nlxhwSTcsaaYklsbMlf1IrhNGjYiAxQT
         gmwi+07qntry8/8sxbnovjFNddOVskOextd9AjTQzvzqOJWAdiA6skxNyWnUzzlDD2JM
         mI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW889SPOwgFFhxHRtdPKf47l2Ik6qE6FWvCOtAsa83P3TQeNYQG2XP5m3EDBDDshehRRUtk0GqDX5f1TK87fJjwyL0aFFnvH/X49A==
X-Gm-Message-State: AOJu0YzF9SuriPkpZea1FBy14BhZHi/ZMM/evtFHoxFL78Bl5dfCCpRb
	/i34tW4NsUxnSX7JNrER0/MsUPP/GnyCf3Bb70ASYNDlR9TO2tu1JGHRcMusXKuJR2y7kI9a5eJ
	DwdA=
X-Google-Smtp-Source: AGHT+IFdfwf81v1W+wySpJ76jOG5eIUy0V2oEYWpmvSKm4+/wZYK5usVUsAOja/4SZhQfVLrh1xfHA==
X-Received: by 2002:a50:cd12:0:b0:56e:2c1d:1174 with SMTP id z18-20020a50cd12000000b0056e2c1d1174mr6653782edi.4.1713777330577;
        Mon, 22 Apr 2024 02:15:30 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:7d:af2:ac50:1252])
        by smtp.gmail.com with ESMTPSA id f11-20020a056402194b00b005720cefe0d2sm931590edz.52.2024.04.22.02.15.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:15:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bitops: Change function return types from long to int
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <DM8PR11MB5751439B2053D1AD07BB8AD9B8122@DM8PR11MB5751.namprd11.prod.outlook.com>
Date: Mon, 22 Apr 2024 11:15:18 +0200
Cc: Arnd Bergmann <arnd@arndb.de>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4BD934DC-5657-41E1-A9D6-226886D2AA8B@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <DM8PR11MB5751439B2053D1AD07BB8AD9B8122@DM8PR11MB5751.namprd11.prod.outlook.com>
To: "Wang, Xiao W" <xiao.w.wang@intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 22. Apr 2024, at 07:24, Wang, Xiao W <xiao.w.wang@intel.com> wrote:
>=20
> Could we change the return types to "int", instead of "unsigned int"?
> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html says that these =
__builtin_*
> functions return "int".

We could, but changing the signedness breaks assertions in other modules =
and=20
drivers (e.g., where min() and max() are used) and has quite a few side =
effects.

>> With GCC 13 and defconfig, these changes reduced the size of a test
>> kernel image by 5,432 bytes on arm64 and by 248 bytes on riscv; there
>> were no changes in size on x86_64, powerpc, or m68k.
>=20
> I guess your test is based on 64bit arch, right?

Yes, except for m68k.=

