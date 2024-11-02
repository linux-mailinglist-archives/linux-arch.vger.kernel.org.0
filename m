Return-Path: <linux-arch+bounces-8782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5A9BA1A1
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 18:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B921F215D3
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 17:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1471A3BDA;
	Sat,  2 Nov 2024 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJh+HUR0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1E199E8D;
	Sat,  2 Nov 2024 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730568115; cv=none; b=NPbJO5y6mdWOovCde3b1qoWm1Hz4NUWppAxZ97EK2GdKPDmXWVam+aq1EHvMIw+eZwnrfpFDhATKDbJJLzeVQWt7m0fwiSM+flYTeL2G76aERNu5ScKi09YURKPKW2cBP7dDfKpZNhLt4m+HTsuYProOX+SA0iGe3yU3kTxIfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730568115; c=relaxed/simple;
	bh=7CS5N4H9kf7aemeGcQgW3i6MPpmeBBkH4/f6lovOV7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/lOdYOAttfEOk6mz5o5kEvkaHtSI4CWFu7GzZA4vssFLdXSBJpLQe1MqkEIKVAjJpKas66NlV4lINf2ZWwRvqiEXk9JuX4HJGa8i+Jav0lVBsjGCH+vqiKhnU+vgjm4XZVCgKsbzrlRkF5U/v/8u279CubZHq0Wv4NLvX2uKSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJh+HUR0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d447de11dso2316012f8f.1;
        Sat, 02 Nov 2024 10:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730568112; x=1731172912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8t9oRS8jqFz7JqVHrKzcZwls154V3gx6wMcbOAYsmHY=;
        b=MJh+HUR0MM+a2O4rSMzQnnF11VzdC6YWbqALcF8RgGGlaUbngYkkJnuC/lNDmrKwaK
         KgqWzMGiUK7tA8ZjXKYhbHU14BuNrK4udU1kbZ/3B1IgwtuvNY7R9SOTFIeA1+xf8kyf
         gh+EL/rpJfJrF2aY8UTUbLhu2fJOVq9zgtfJxZxKtC1bqm8ojG4ofBovomRmtC142FvX
         1/5KmIx3vA9+OCyifAt4jcKj/okWNWqoNS0K4airkyjRZfM+CWyeFD0A+Ny5nbvQijhN
         7DRzXMa3D14EXSKqKCMGx7ePgHl7jq5QIJWVdICXOBHPewrhOwuSyWsec+WRNc47merp
         qCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730568112; x=1731172912;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t9oRS8jqFz7JqVHrKzcZwls154V3gx6wMcbOAYsmHY=;
        b=a6CuJUs8MF1wpFVqR1WA7c3ZNb0Oq2THAZ1kerQD/0lUdK/7F5ojHbWn1Ejd7GFKu1
         MpIwSCFhyFSmRVY8O6waaHXqIZOWq6xL56i7SGSkBpnebOa80OuXvOFwzfs5MTzTQn6R
         9WZFw+EyExcFy9t3xPCQ3ofa3IuFFQf1wt8xrQn17xSkkloSL7R4l0FSva+XD6djPSK0
         mp81YQzyfzMlANxxwEyLOCUw2//3g0jD+9PkQHcxD1S5KELLxsO5zAqwLxvJ5/nivm6V
         OWNaEcm5lv+Z+A7Js7iK1Zpy308f3qGsPYrmdqFXqr3Sp92LMKiu0cV5ThxC/eltC9j4
         zPsw==
X-Forwarded-Encrypted: i=1; AJvYcCU2lkJE8ygvvOoWPckNOV/J84fSvzKLFI1th0Zr1WytcihEJKnWDPM9W8Tc28TuhZhezkuC/2Tfqr1aAw==@vger.kernel.org, AJvYcCUHPJMZ4tz33UAEliO8XlkRjSjg1DrcDk7Zn+9/Vf14poLNQGH2IOoD1lIItPPLFf8/aksrAr8FNKafCQ==@vger.kernel.org, AJvYcCUmrayFmTbX7X1J50GM0TR8IjQQZYbNlzXGfafDP2wVqhGtCXdvOWQbwWIOFRuHjXPUnEG8OmmOwywlhA==@vger.kernel.org, AJvYcCV4p4gwcg+GmFQhMTZDfWOXs1xyhC7/RFdlCkGpg/e08XkeEzpiJwmrOWYwTmwNR0QO516iY02iBgBX@vger.kernel.org, AJvYcCV9cCndkOvQZkvf2Q3UpDKxitQB4Wd2U7eHKJuaJkoN1/PhvwzcKjwhUJei4Dr4Y283v3br03RBgdXjeZIM@vger.kernel.org, AJvYcCWPhLLJT60gGLNiImX/zxzAKhjQKIJ5U/HTXAbTDv3ypRNt7h2r6mDspW9W2aEKieh7DyVHyCyTbk9y9A==@vger.kernel.org, AJvYcCXJcF3AI7JrTSWPtylzR5Lglh/cUuLeNbb3K+vnM0+clCmhYdo71yRj8OhxQrQZniPViro6SB8VtNJgKDyR@vger.kernel.org, AJvYcCXi2XsNqzjWIdH88CvJjHZVn+yY/NTZEfpteXtkPRdu3RmWU62MWha56ZkjNvegAcUQA27zNRYNUItW6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2+cDkW1lkUnNHGc/X1UTSPqQxXYA0u6ewUXoVln/6n29Vkq0
	xG2CZcWeSOWCt2e3tjXweLBiZukJ+wsrWI7EAH4uk+0i19dqiAPm
X-Google-Smtp-Source: AGHT+IGi2uIS+syMjf4Zb3uVjiFcNrb793MRtp10AmIBh8gU8g/TTGAjyc3KAIibvpjiJFec6IflZQ==
X-Received: by 2002:a5d:5f96:0:b0:37d:324f:d3a9 with SMTP id ffacd0b85a97d-381be7add20mr8712682f8f.9.1730568111468;
        Sat, 02 Nov 2024 10:21:51 -0700 (PDT)
Received: from [192.168.8.100] (89-24-32-122.nat.epc.tmcz.cz. [89.24.32.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b80sm8686121f8f.10.2024.11.02.10.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 10:21:50 -0700 (PDT)
Message-ID: <8784622f-ccdc-4086-83f7-50462d6369df@gmail.com>
Date: Sat, 2 Nov 2024 18:21:48 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 04/18] crypto: crc32 - don't unnecessarily register
 arch algorithms
To: Eric Biggers <ebiggers@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
References: <20241026040958.GA34351@sol.localdomain>
 <ZyX0uGHg4Cmsk2oz@gondor.apana.org.au>
 <CAMj1kXFfPtO0vd1KqTa+QNSkRWNR7SUJ_A_zX6-Hz5HVLtLYtw@mail.gmail.com>
 <ZyX8yEqnjXjJ5itO@gondor.apana.org.au>
 <CAMj1kXHje-BwJVffAxN9G96Gy4Gom3Ca7dJ-_K7sgcrz7_k7Kw@mail.gmail.com>
 <CAMj1kXG8Nqw_f8OsFTq_UKRbca6w58g4uyRAZXCoCr=OwC2sWA@mail.gmail.com>
 <ZyYIO6RpjTFteaxH@gondor.apana.org.au>
 <20241102163605.GA28213@sol.localdomain>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <20241102163605.GA28213@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/24 5:36 PM, Eric Biggers wrote:
> On Sat, Nov 02, 2024 at 07:08:43PM +0800, Herbert Xu wrote:
>> On Sat, Nov 02, 2024 at 12:05:01PM +0100, Ard Biesheuvel wrote:
>>>
>>> The only issue resulting from *not* taking this patch is that btrfs
>>> may misidentify the CRC32 implementation as being 'slow' and take an
>>> alternative code path, which does not necessarily result in worse
>>> performance.
>>
>> If we were removing crc32* (or at least crc32*-arch) from the Crypto
>> API then these patches would be redundant.  But if we're keeping them
>> because btrfs uses them then we should definitely make crc32*-arch
>> do the right thing.  IOW they should not be registered if they're
>> the same as crc32*-generic.
>>
>> Thanks,
> 
> I would like to eventually remove crc32 and crc32c from the crypto API, but it
> will take some time to get all the users converted.  If there are AF_ALG users
> it could even be impossible, though the usual culprit, iwd, doesn't appear to
> use any CRCs, so hopefully we are fine there.

Hi,

Please do not forget about dm-integrity, it can use crc32/crc32c for non-cryptographic
integrity through crypto API.
To test it, cryptsetup testsuite should cover these variants (integrity-compat-test).

Also, libcryptsetup can be compiled with userspace kernel crypto (AF_ALG) as a crypto backend.
At least, I think we never used CRC32 though AF_ALG from userspace there...

Thanks,
Milan


