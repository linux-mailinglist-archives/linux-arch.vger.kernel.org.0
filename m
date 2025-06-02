Return-Path: <linux-arch+bounces-12180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5AACB525
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 17:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28163BA7D5
	for <lists+linux-arch@lfdr.de>; Mon,  2 Jun 2025 14:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E7422DA1F;
	Mon,  2 Jun 2025 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SF6yYloj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D51122D9ED
	for <linux-arch@vger.kernel.org>; Mon,  2 Jun 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875581; cv=none; b=UVclzEBoceqiSqwQ9x4yvbaoVh2gy1IrMa1pqIeHaVa/pYFgk8ylYKRPorBymFZCcVvUmsGxyUJKZV2r0JH1cJcEjUS/cTT5pYE8gFMXVZjLRrw1wqY96iGl75tYjkHqetrhNDFrH6gyR/k43T2OI8BCaxwXkIXrk31V0AnnXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875581; c=relaxed/simple;
	bh=BMdmqxyCVbd7fEc++ql37zNwaBo1D8/TV+gOsCFIGWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlN1sRZ0CuuAqAcRP2mqOzaKiXmTmxttSo7AzyYvMFZaJXzWBrfZxDZNUmNBspY1jxKmIcgU4A3uzqd2IbxjWLWxyTeEHgTJCBcXXrCTBHEnmcvlDnpPl8bHuABCQWQdd3PK+B5dyJah4sILdmLqUabwsSUMbudLvixas9SukDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SF6yYloj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad88105874aso701580066b.1
        for <linux-arch@vger.kernel.org>; Mon, 02 Jun 2025 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748875576; x=1749480376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg0dwJvYfbYUNtSY86lpjPZ26U71B5eHF51TBSSqPe4=;
        b=SF6yYlojOixJbBBhIxUACxynoF+Ykc+9DyX65vtQ3Lhl/X5Io8anAasHAL50IOwwDK
         B9gqP9+TGWQDY9+YPCj/dfBj7SeBHS7WCv0NtkeOdlNGO7HcRrUM/muyIMZ64yJWs+f0
         RqtkoZ+a1Tl4xCPOpZpsq+yfgH4mR6xYdK67I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748875576; x=1749480376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg0dwJvYfbYUNtSY86lpjPZ26U71B5eHF51TBSSqPe4=;
        b=wyRlQIoFfIyNrfjUQjpG5jIhH0jdXqi/tgAm+DdBkAWpG+7GfUkXN1etbEKctTkByP
         oOoClBhtcUtci0AtVgC/0bbVVCvmWhpVlBbgaIljv+O9lXpwOR1HsYD0dj828F0YUUU4
         KFeUlfxuB0OwVThXvLjxFO2EfVhA1ddxb0nFPQWV0/+BJ22r6fijijZSzUTn154D4PWB
         jx12bnD0A64o4obNxsw5mTg7fTA0SIJ/1CUSCeD5SSM0WFKkb01PekwCWVP+z0Ln+mgm
         5GSWMGnkXFnY6b+EqqGJoiHdIpRhx9wxKpJTx0QpTE9nz8L425+UzaN6bHY9iR7IqjOr
         6tlA==
X-Forwarded-Encrypted: i=1; AJvYcCWeFRq7bxN+4bZZAXawxAPkAhcGEwNdySyHwRfT655QrSthA77bZsIAEvRaVXft47mnzPl4Y2bnSaUU@vger.kernel.org
X-Gm-Message-State: AOJu0YzEovsiKkjtXDaLZtdxWBMX4i0fXu16GJYgIydUh3ABPnB/R1kg
	WilZJltCPRN04ZUcd8BP4YgAljQB/24h115V72I5w3NbcYy5P6Z+1pKP5E+CM2zKQwBWIVSv+mv
	59uEjMJM=
X-Gm-Gg: ASbGncvLnurnUufCwVKG0MNQxeKcNXQaNpV/UCSxYFi6cmBwloihClo/NlGPvReFDqo
	yF5aEkPBqGUl2gy0uXM6D4cpqJrdulkruG41ngFZcklacIFES/2Y8/I20Z4gQQLAhlvb1eQ/M/z
	07CLbI8PODe++oeItelc9yLFL8S7z59ycdtNJMvTo+wj3688YmVmyqueAsXPj//zZ8JlO/aiZ1K
	leErZAfdEh2IKtyZ+7gYsGxVKNfi+d9r8lWlNWi1TxMKhtGOh3wF30Ka/3iFHpjAk+HyozrrXhC
	qFofeAGVIZ0epojZABheyhVbL/TP+oLx1Ajf1OQcE7iJbK5qO4ukacFdDm7Iz9IyMoFzMl3kcAv
	2W7hLjffc9d17lfN9FAdvOceYbg==
X-Google-Smtp-Source: AGHT+IF893ko4gkEDwHZnVbXtt2n8GqnOGJYzldl7ZWXYxS5RG+uNUnoqvClA2yjjZFh0EXy7Oaqgg==
X-Received: by 2002:a17:907:d92:b0:ad8:8621:9241 with SMTP id a640c23a62f3a-adb32598940mr1383257366b.54.1748875575632;
        Mon, 02 Jun 2025 07:46:15 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c2b286sm6311251a12.9.2025.06.02.07.46.13
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-606741e8e7cso1355624a12.1
        for <linux-arch@vger.kernel.org>; Mon, 02 Jun 2025 07:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW90pjN+oH3aAVEMQa8NmX8cwRBTrBEY4tTsuMoQSJj/R33FFpW5zydoyaLjNoY12y/aGlUvuk2xJqO@vger.kernel.org
X-Received: by 2002:a05:6402:5205:b0:606:3146:4e85 with SMTP id
 4fb4d7f45d1cf-60631464feemr3563572a12.4.1748875572780; Mon, 02 Jun 2025
 07:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428170040.423825-1-ebiggers@kernel.org> <20250428170040.423825-9-ebiggers@kernel.org>
 <20250529110526.6d2959a9.alex.williamson@redhat.com> <20250529173702.GA3840196@google.com>
 <CAHk-=whCp-nMWyLxAot4e6yVMCGANTUCWErGfvmwqNkEfTQ=Sw@mail.gmail.com>
 <20250529211639.GD23614@sol> <CAHk-=wh+H-9649NHK5cayNKn0pmReH41rvG6hWee+oposb3EUg@mail.gmail.com>
 <20250530001858.GD3840196@google.com> <20250601230014.GB1228@sol>
In-Reply-To: <20250601230014.GB1228@sol>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Jun 2025 07:45:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjO+t0FBrg=bHkbnXVsZ_U0TPgT9ZWUzu12-5NurCaWCA@mail.gmail.com>
X-Gm-Features: AX0GCFuodXM8SKmhJCuuDQhW2iq8pjrSnsjy_QXiBCm4TA9D0azfhocKT2KWhmk
Message-ID: <CAHk-=wjO+t0FBrg=bHkbnXVsZ_U0TPgT9ZWUzu12-5NurCaWCA@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] crypto: s390/sha256 - implement library instead
 of shash
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Jun 2025 at 16:00, Eric Biggers <ebiggers@kernel.org> wrote:
>
> I implemented my proposal, for lib/crc first,

Ok, I scanned through that series, and it looks good to me. A clear improvement.

         Linus

