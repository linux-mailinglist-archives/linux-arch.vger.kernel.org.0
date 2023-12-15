Return-Path: <linux-arch+bounces-1095-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF9814ECF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129C31F23031
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 17:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7BE4654A;
	Fri, 15 Dec 2023 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A6cNi9MM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B849F6E
	for <linux-arch@vger.kernel.org>; Fri, 15 Dec 2023 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bf82f4409so1981283e87.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Dec 2023 09:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702661292; x=1703266092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJgdaQfVEOqTf6cuulaJ0BP/0PqG9vdbBBj+6Nf4OLQ=;
        b=A6cNi9MM7UFbdYUBBSplxkAVXogSCfn+9QxF8Ft2BB9KIMfSdPnEOoG6c3B0r5Zm4j
         2blxH98ngsFTm8aWUzhNskxNN5dkMVCVoUs0qWIQyZ66wOWlkB8tZk2Ra3CUCF/9hUtj
         g0exxxpHYiNSyWGzP3505by1Z/0b5s84CoEhMGdxprQCmTf9Y5QiYfkAzPQUsx4h9EGs
         TbA8Pf8ITvqzPL0JTGcBsyEWOyXox/5dLjx1nxpRErCcvfc0lcJlhwwP5dnTpbAvzG/G
         I9B0xLLPEVE4NU2NiI4i5Gfqgq1aB0hpStJzSjffWQry/4kVCr6cyzRCPkcgRKs0Ow7R
         yjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702661292; x=1703266092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJgdaQfVEOqTf6cuulaJ0BP/0PqG9vdbBBj+6Nf4OLQ=;
        b=p1y7vIJjV8fQTze79p1wHrxuUNU9tA0nGADqWcYjcQt/WwaoCDe2XD2MfJzmvBuSd6
         L/kMHHqnBBgqORM+dJt55yWkjQnTRZPWRePIIrQTFfzVPjL0KUhT+X6pYYURNr2xbIfn
         7lH+SJtB9nUxNaBBOsq4ToEnxcF1eJNZQ1ZNj8+bIDi1p+ntAgWc6wI0PvAOXrUxlVnZ
         0PDAKEH6uBpiwbTEeAYVvwFLYXiCF3aAR6RiJk3AAi9voHIWUjKFuAMUgQVYa3NOwsOE
         koxDpB9WR2KhnFks5sYMlAX044BbiKxF98wfliw0/iIK/V4PLH6JZwsdxmFnKlad1Pu/
         /vHg==
X-Gm-Message-State: AOJu0Yx5v3697pg1aYE7WtmHJYn9KQDr1jpQ14rRSut0rYxvOzhAujCY
	KpagzCefpS6O3ejcNraS16KDKKZobuEtzIsfRa/sdeICQ14XMINs1JM=
X-Google-Smtp-Source: AGHT+IHKYDeE58bHo7Yl9+9lemxIyPXLPvC9cNQ8Niqe6fY5V8Hzg+SDAeHsy8YyZnBE7APvju7Ja/+sP0nqPq3dyiQ=
X-Received: by 2002:a05:6512:2354:b0:50a:a872:3b1c with SMTP id
 p20-20020a056512235400b0050aa8723b1cmr8848174lfu.27.1702661292417; Fri, 15
 Dec 2023 09:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com> <20231212-optimize_checksum-v12-2-419a4ba6d666@rivosinc.com>
In-Reply-To: <20231212-optimize_checksum-v12-2-419a4ba6d666@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Fri, 15 Dec 2023 09:27:36 -0800
Message-ID: <CALs-HsvjFhBnD=8HgcW3EStMioa7P1FvrJ_yGsXLHjUSEcm6ew@mail.gmail.com>
Subject: Re: [PATCH v12 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:18=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support static branches depending on the value of misaligned accesses.
> This will be used by a later patch in the series. All cpus must be
> considered "fast" for this static branch to be flipped.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Reviewed-by: Evan Green <evan@rivosinc.com>

