Return-Path: <linux-arch+bounces-4131-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26058B944C
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 07:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68085282E42
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 05:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0768B200C7;
	Thu,  2 May 2024 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeaVLHco"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A527519BBA;
	Thu,  2 May 2024 05:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714628572; cv=none; b=bokGHwnbvpbVXs2sFupuNjk7dHxvAIoZ7PqaE+xq7BYDyQkh0kWkwMGpf4sEvFg91AUYSG1jy1z8GzBIAuf9c7onEEgjZJPTTu7CDuHfjXRn1R9J2ktckIXABW0EER73rmWT1411uVZ5mma79cd72oFey387sSXUZMdMnpBFspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714628572; c=relaxed/simple;
	bh=q80NBCN12WyBKOEAMI0TgHPy0nVAHhJycd/h5pUg4Fc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=F3Ay68FZq6YwIxgQ3OxjRdJMsGnvMlGEUOZNfc+tXrHpviFiOqRU5MajfXlB0i9l45Nx2aQYiOFV7xp/TkFxHmxqQgeUcSBakBxWkv6bJqlCrdUo1gHmCPsVWEXn036mIruNOGAI6JZjoDIpKX97JcwbxwVbF23jkFAvjQi7Fhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeaVLHco; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b27c660174so1971364a91.1;
        Wed, 01 May 2024 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714628571; x=1715233371; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=796hv8eOMd7PfyPpAb8yeMndpUxaKJ+TPO8L+IUd2Mw=;
        b=CeaVLHco1I2eKpmTHAIJGr1wMGzlEaCIYgrRFiiw3diotelOqd4vRawCNLMmWtogwe
         yD5wm+3NN3xawzTG5Z1qo4AotHQIOg0nDe3TGuoVsxeJ3dGlJtgmBXDpeoAZhc56w4iU
         zUdyumjFK82S4EfLA80cgIOzRfCUL365t+0ynF/+sMtvDVif1QxqKQln1EVw6Kyl4KyU
         V+bc5DyeI6aYYodpXcQo1hx//vCHFMxEcP9gCINuM5GTX0HOErmpKMPg1ApEVtWl9mcz
         bfEo++60DNzOy4f6TSTSXfCZgy63hjgnJcgqTFjq9Zub0wnZiHt1tpCNyWEXIo/LYBqk
         ClxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714628571; x=1715233371;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=796hv8eOMd7PfyPpAb8yeMndpUxaKJ+TPO8L+IUd2Mw=;
        b=Ru3wx5wU3PCsU4ShT6NTMYw3cCU/+Kywv2AfN9c9djLjhvWSEz5rk3OBpta5mxSmzj
         gCI4cIh13hhFQdlcgHriLJhwPEj41x1UQS2wUnrWPxIcBySUua6pasbWerGgQ+jgenzR
         XHgFPYjoGgfC3eIhi9t6Hbk574Qt5K8qlXpJf4UMJchJPk5AD5W+8zVSyeX8z+3D2Emz
         IrQA+OdytfhBedcpnLdMdrypULXaFJO/Ot90bKY6ombXTi/+pIGHXzRTkxqWAqu9hCO6
         THz+ym/eWmlwAxh5R1OAU+ns42kaI7fqhEjkUOOlUlx6y91OK60CxRr32fu5f34WnUEp
         kSCw==
X-Forwarded-Encrypted: i=1; AJvYcCW7WJLeRkIvz5HR/qUUCfhhhql2LM130LXwGMZE2V145HUb5lEhUi1dUBzi9IvnJkV7jYbzK7zbiUyxNHLbyKGxgvuKuzKqCef/4H+swxVzAKXl0H33IkCDkv1eQoqdKsRjm8O1cJ9YWHt9x5J0RWhPr+hs2spQn+f04BpwhRGu0+q3
X-Gm-Message-State: AOJu0YwdKA4CJ/RTCkaZk/CRW7gvZx83SdFrXbEAWc+pH1Q42rl/kL8u
	+XaYFsn4NtJTBOMkbBm9EtMAW1M35aDtXDW9hGWvcYVg6HRWSFUt
X-Google-Smtp-Source: AGHT+IHD1cw7Ul+OMpqw8vQp/IawUYjrFoGHzbRXMMRhHbrx6pqk8IyNz4lDxjZjCZU7748CUgwXZw==
X-Received: by 2002:a17:90b:5144:b0:2ae:e1e0:3d8f with SMTP id sd4-20020a17090b514400b002aee1e03d8fmr4107869pjb.2.1714628570556;
        Wed, 01 May 2024 22:42:50 -0700 (PDT)
Received: from smtpclient.apple (g1-27-253-251-179.bmobile.ne.jp. [27.253.251.179])
        by smtp.gmail.com with ESMTPSA id ck11-20020a17090afe0b00b002a20c0dcebbsm357993pjb.31.2024.05.01.22.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 22:42:50 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: "D. Jeff Dionne" <djeffdionne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Date: Thu, 2 May 2024 14:42:38 +0900
Message-Id: <23A87C03-EB55-49A1-BB55-B6136117F0B6@gmail.com>
References: <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
 akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org,
 dianders@chromium.org, pmladek@suse.com, arnd@arndb.de,
 torvalds@linux-foundation.org, kernel-team@meta.com,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
In-Reply-To: <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
To: paulmck@kernel.org
X-Mailer: iPhone Mail (21E236)

On May 2, 2024, at 14:07, Paul E. McKenney <paulmck@kernel.org> wrote:

> That would be 8-bit xchg() rather than 8-byte cmpxchg(), correct?
>=20
> Or am I missing something subtle here that makes sh also support one-byte
> (8-bit) cmpxchg()?

The native SH atomic operation is test and set TAS.B.  J2 adds a compare and=
 swap CAS.L instruction, carefully chosen for patent free prior art (s360, I=
IRC).

The (relatively expensive) encoding space we allocated for CAS.L does not co=
ntain size bits.

Not all SH4 patents had expired when J2 was under development, but now have (=
watch this space).  Not sure (me myself) if there are more atomic operations=
 in sh4.

Cheers,
J

>=20
>                            Thanx, Paul

