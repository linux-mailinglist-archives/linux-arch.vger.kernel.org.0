Return-Path: <linux-arch+bounces-894-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FC80D0A9
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278E61F218DB
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 16:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1286B4C3DD;
	Mon, 11 Dec 2023 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hb/jTd2s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECDD0
	for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 08:12:29 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77f43042268so305761085a.1
        for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702311148; x=1702915948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZpS7YigJlvbtafE8s+IgfD2mhqkpNW2HnzWlJXZ6u0Q=;
        b=hb/jTd2sTBZTQK/zyjqlOJFdtpYmHq/6oAMyodOsF4zZZJ3IzPBpoxcyLYPMRCFipR
         rOe7gD4ExrSm9Pgw9j5pu8j5nBJy3iUFYDy7KQ6Imaen+MSbBQwSr3AA12Y5Uw+FLAYZ
         SCIZYnBXSfAJBVYk12WiKHA5G8rmX1ADvwR7pF1+4a7gNzBPrvqABFHGsuEI467Dtg5Z
         WbU65UzYfqpDHEf+/wgGrEpPsppOOzIUdRwwUxIrHnMw055xTLQnDJccBeLHcpiC2CVT
         avwaEOJMn86choOT2nYDdqxgGk50bNAoFrURH9KXZ2UNvPUB9eQhBY4O+TtZtomXuh5c
         9JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311148; x=1702915948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpS7YigJlvbtafE8s+IgfD2mhqkpNW2HnzWlJXZ6u0Q=;
        b=X60A56xwyff5X/Ru3F61rpQ5vt57cvn40U8uqttg/j4QGTvuc8T48FcBJuBPg9wVr8
         sn3wrixJf0jU8V8hqSlbU/vhQzVH4qm+q2cnZOIo0/g2xrzdthQYjlMJvQXsuGf6/fa3
         igPL/2b+gKIbAWD5yshbIzDcq40VOk7g9BCN2QXhTtSBO5vwv3KS3gOTshYKDJFTMe4a
         YCtCP4M81Fapfwaea/LFKC2fNCjGDCuIhLsOpaAn+Mm4LQLXnlDg5aoZxIhFogGPaaur
         m1eyrjIQ9+1Vgflwu5qJq/6dPx0iXoC0VC2Iwr3aka0R+hcV2nHHjk5/ojzOnF+tGnPT
         LuiQ==
X-Gm-Message-State: AOJu0YzE7UrBUF81wF3baTJLiPIe9fJ/F9nfr937u837bNmdo0zBA5AN
	axTNZqVy0pbQKQUqVin9VueBXQ==
X-Google-Smtp-Source: AGHT+IEC8jdvAnetFbqJVF6lQQw8UXKnB/IQiMsN2t2NyqglmpS9Xy9aZsTAJAYPyNV0NsZe4DU6SA==
X-Received: by 2002:a05:620a:15a8:b0:77d:855d:1b09 with SMTP id f8-20020a05620a15a800b0077d855d1b09mr6457241qkk.0.1702311148452;
        Mon, 11 Dec 2023 08:12:28 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e? ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
        by smtp.gmail.com with ESMTPSA id a15-20020a05620a066f00b0077d78afc513sm3014865qkh.110.2023.12.11.08.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:12:28 -0800 (PST)
Message-ID: <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
Date: Mon, 11 Dec 2023 10:12:27 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
 <ZXczty+Y6dTDL4Xi@infradead.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZXczty+Y6dTDL4Xi@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-11 10:07 AM, Christoph Hellwig wrote:
>> +CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
>> +CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)
> 
> Btw, do we even really need the extra variables for compiler flags
> to remove?  Don't gcc/clang options work so that if you add a
> no-prefixed version of the option later it transparently gets removed?

Unfortunately, not all of the relevant options can be no-prefixed:

$ cat float.c 
int main(void) { volatile float f = 123.456; return f / 10; }
$ aarch64-linux-musl-gcc float.c 
$ aarch64-linux-musl-gcc -mgeneral-regs-only float.c 
float.c: In function 'main':
float.c:1:33: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
    1 | int main(void) { volatile float f = 123.456; return f / 10; }
      |                                 ^
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
    1 | int main(void) { volatile float f = 123.456; return f / 10; }
      |                                                     ~~^~~~
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
float.c:1:55: error: '-mgeneral-regs-only' is incompatible with the use of floating-point types
$ aarch64-linux-musl-gcc -mgeneral-regs-only -mno-general-regs-only float.c 
aarch64-linux-musl-gcc: error: unrecognized command-line option '-mno-general-regs-only'; did you mean '-mgeneral-regs-only'?
$ 


