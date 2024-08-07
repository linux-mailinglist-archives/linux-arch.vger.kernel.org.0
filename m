Return-Path: <linux-arch+bounces-6105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D00F94B2FD
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2024 00:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69821C2115B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DC7153828;
	Wed,  7 Aug 2024 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+Q/zba6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B0614EC47
	for <linux-arch@vger.kernel.org>; Wed,  7 Aug 2024 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069607; cv=none; b=thRPoxmGRAVvJNUQzjXNSFK6TUzTv2WIg7rtIyB2Wg/Jzw2RlyV3KMEJLyIuU6zm2Wt0TYHai5/sRx2+pLUlWLPvVZFMSWvjkekU8s0Bh+aHsw5zJBqBKmv3DFNsxxC8T4zOuqlWaGB/tYePn/ZgKq3qgYLULN+yCw6o5H2J4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069607; c=relaxed/simple;
	bh=32biW44HjRkMPGPPp6hzCLrqIC8l+yMka3jm4zZkurk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGJjivdnOWGbqTbeH1LpVH37wxiecKBnDj5zvWM03ONVktICoOppSft/5e9IvVUA0VGs+6bF6qQ/FaQGgF1s4/Cv5h5NX7wS/+FZI2Up/DvYDhnu+0K0+0prduFvFwGpNV/wvfiWqOfSIb2SU787PqKx6qC9tn21ay5X2mnLmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+Q/zba6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so328553a91.2
        for <linux-arch@vger.kernel.org>; Wed, 07 Aug 2024 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723069605; x=1723674405; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBIy/YIYmaABmQA3j9o1k99kZxl3FitdDB149roFRGk=;
        b=b+Q/zba6EC1ggZw3MC5sca1LpG5wIroFRlDETXO3a0FQgPaBo3fFrmQuNzuU3Yp8ck
         +l/k0k/MrVFSVisfkv16+GWuXKB7DcUOhU6Z7r34kSEyixQK4lhcZn+QowPclUbQ1Suz
         QjHrNELqhL6WrpvHzbWeu9gTbmDLXVFsrgyRR+dqbMYlklLagOWi3cuPhN+U39Ol+jHP
         W7QTO9ptHCwXtfzyNmZIRrv+qG9m0mtAM3eYEVW++YRrjuA/b7DBkQb5Ay3SKNeGkMaW
         Oi8BPggNc+Gl66SbldLerxP09Sh7tUcaYYuIPLX9xHvUP+xFE3E6afOXzUW/mmhCtvqA
         HjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069606; x=1723674406;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBIy/YIYmaABmQA3j9o1k99kZxl3FitdDB149roFRGk=;
        b=Bn6dKlHHGE3WZ7dfqkI0YbT2tfsFXofVE77nOC9KF/W8+uMuLQ2yVfWBy7xM4TSLSB
         TiW9d20dfwebArUYEtRhqQzcTz9TxGgTqdELsqhslvsJf/1ArQvogrMosmezAr8FVHcM
         OEFimhLsILfLev0/27rM/lBU2vhsr+7HaPLkDCLO6F2F94O9KOubL+pPU26c8XGa3zfT
         +V9pXdXaEJPt6LAtuaPdslCfdqqbJWuKzlb1+aYCUlCWQWCPk7BmRsqizO0iRlXPkOiC
         ggUFvxrPnTRAb2CgOhR/Du1lVZAkmqfVmuLCMKcDgsYaFh/chCvfP2vg2HW1zDzuQNNU
         ysdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/gsgIChR+pF7dhvu90Lf9WdODy4SYh62x76P2GpUhZtnTSY+xJucPDb/O/QO6T6RaJfjaNXcaD13UW34ssUWeYXEHvlHNt1Rqzg==
X-Gm-Message-State: AOJu0YwspWjr58tPhyFr8c98sQLRK3xjt4TJG8WQgmyEvFdz4RY+qrko
	FwZ+RaVVniSPAlhPZqUipaz1OjDEoG+sC3UqyQmTUnRKXTU5uXUXpYL1v4PEB4g=
X-Google-Smtp-Source: AGHT+IGd6zBFgLdZrc5fpXn4Fk0DlJIehtL2v1U5+1wFJBUpqiMspCMgOYDP5uaNavgy/IJn72zPoA==
X-Received: by 2002:a17:90b:2350:b0:2c9:7aa6:e15d with SMTP id 98e67ed59e1d1-2d1c33d4a01mr27917a91.20.1723069605605;
        Wed, 07 Aug 2024 15:26:45 -0700 (PDT)
Received: from localhost ([2804:14c:87d5:5261:6c30:472f:18a6:cae1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3b59ff2sm2100472a91.49.2024.08.07.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:26:45 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,  Will Deacon
 <will@kernel.org>,  Jonathan Corbet <corbet@lwn.net>,  Andrew Morton
 <akpm@linux-foundation.org>,  Marc Zyngier <maz@kernel.org>,  Oliver Upton
 <oliver.upton@linux.dev>,  James Morse <james.morse@arm.com>,  Suzuki K
 Poulose <suzuki.poulose@arm.com>,  Arnd Bergmann <arnd@arndb.de>,  Oleg
 Nesterov <oleg@redhat.com>,  Eric Biederman <ebiederm@xmission.com>,
  Shuah Khan <shuah@kernel.org>,  "Rick P. Edgecombe"
 <rick.p.edgecombe@intel.com>,  Deepak Gupta <debug@rivosinc.com>,  Ard
 Biesheuvel <ardb@kernel.org>,  Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
  Kees Cook <kees@kernel.org>,  "H.J. Lu" <hjl.tools@gmail.com>,  Paul
 Walmsley <paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Florian Weimer <fweimer@redhat.com>,
  Christian Brauner <brauner@kernel.org>,  Ross Burton
 <ross.burton@arm.com>,  linux-arm-kernel@lists.infradead.org,
  linux-doc@vger.kernel.org,  kvmarm@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 29/40] selftests/clone3: Enable arm64 shadow stack
 testing
In-Reply-To: <20240801-arm64-gcs-v10-29-699e2bd2190b@kernel.org> (Mark Brown's
	message of "Thu, 01 Aug 2024 13:06:56 +0100")
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-29-699e2bd2190b@kernel.org>
Date: Wed, 07 Aug 2024 19:26:42 -0300
Message-ID: <87sevgdl5p.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mark Brown <broonie@kernel.org> writes:

> In order to test shadow stack support in clone3() the clone3() selftests
> need to have a fully inline clone3() call, provide one for arm64.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/clone3/clone3_selftests.h | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

The clone3 test passes on my FVP setup:

Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>

-- 
Thiago

