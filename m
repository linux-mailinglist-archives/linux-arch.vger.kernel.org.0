Return-Path: <linux-arch+bounces-4523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5987F8CE669
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8731C21B19
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2024 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E31812C47E;
	Fri, 24 May 2024 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCNjZdbv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B712C47C;
	Fri, 24 May 2024 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558801; cv=none; b=m/nomKgi52ts1mYL1s7ScOsg8tnYJ5uSepeUYxAfvZVojhxtxH9QgdFzeJNeFO7zk30BpJQgKR6P2k+3Hm4NFszXd/22hzVhmMBOxNbQnOk9gDVe/mC3m6erYhqr3Pdxzwn808brmO9Cd8p244fQVoCGE/AK+8RT+KDuwaPmTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558801; c=relaxed/simple;
	bh=mV+N6Vuao2DF+3LDDtNXzl30dnyKutNjJGhqc6i6P+I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fOnciumaCGEk2ta+/waDbTfbNpn3Eggg+u57TsfHWyDFnr2dtEnuIG5RDV62EJYxDyzWOnfeYBm2aXc2jm7jc9MvvhoQxFaCCJgonrc3Oy8yq1V9Uf/f/pDZORvPE4Xe5BNtUbwziKPp7W5CEf+NjIzX4qBIz6gwC7cCoa91Omc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCNjZdbv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f8eba8dcfcso803880b3a.3;
        Fri, 24 May 2024 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716558799; x=1717163599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=b0/TSFREZaBctG5vlYD0Hmuh0/DxJ4bPlmcsHcY/PdU=;
        b=WCNjZdbv69OaT8A2HoNLPgwbcApDDW1D09UA5W9YJQzzMn1n/SBYKR+5bZQwNb0+23
         ICiVtOpVbTPZYwIaHWkctl+ZKH36x7O0bzMaLJgS4dHHClQjxTIVjbi5fI5b+Z0pJOlP
         aKCsXeQ/jnP9SFc4LSRf9Xu6ZXcuCaL7bAe4kISMOkAkG1OuN2njOT2eDZVBMKQbYdu7
         1rMOi3OIQNIS2+VpFmfgCp4rgeu2A8JeJQPiB7wGC8JL0p8iHgB/5VZDZxXVC7QpkR5+
         qOnpv8g6Kj+bpFk56kW2BJcf9bMQZGLUMqmb/eVzVkEAvHpZFADuAyh5oA0/AnsL+c8E
         Ib8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558799; x=1717163599;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0/TSFREZaBctG5vlYD0Hmuh0/DxJ4bPlmcsHcY/PdU=;
        b=wY/Fslk+IgXUWovrWy26udycEq2B1W0ctdOB175GJUrB7i/o5XC4qbrTHfYmprGyar
         MtAXQFQCkZsm5jLKbAhojqIel8F8kk0MetMyKx/aYG4Ojw2eNsATKI4+FNS82ldsVnj6
         bsuOnvjUxWtraxbjeQfZofHRCEkTQDnnm79krQ6+cI2OCPbxabU8rC8QDn7iJiQkvTi3
         bDoWeCFIGAYRE0KZDbVrDJEfiH1hLHIJfrxDQbmuPVcqWsg/yAqFq4kbnvpBIwX788w+
         6VAjHuT8aB135e6gv6T6x64DXtIiCIphctJjxoGINxCkO5Rh3utGTksomLyYZ2ju6rTQ
         EXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWunFPUfH48KPX1U3HE43a+0OG04Ii1Bof3S/7z7+S5/gCXOEORpjPobOlaHRLhDPjm7NYHP7AGtHq8QXsORot5M/5Q+ZnAawbLGMUwIUhgLiXJ/o4z1ZatHEe43O2yoyqYpqkEesglRw==
X-Gm-Message-State: AOJu0Ywyt8ae1QH2WYU8QhBVlVsW4KE3T/zu9uV0BlOgj4PozXAjOx4o
	gvf7K2IFB2uLq4tVFrvlxisR6/SHW7tmWAoO0bFAj0TWk+RN1kJg
X-Google-Smtp-Source: AGHT+IH3aQaFlbwWMDNIYwkEtj6N6w858o4MAHD4uUjiZfFfdXxaGquXuXeOwr68wYrmKImdEsesTw==
X-Received: by 2002:a05:6a21:99a4:b0:1a9:c4ca:dc74 with SMTP id adf61e73a8af0-1b212ce1f54mr3260189637.5.1716558799320;
        Fri, 24 May 2024 06:53:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fc057e52sm1127383b3a.57.2024.05.24.06.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 06:53:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <91f8b384-9a6a-4435-9f9a-7a65a7c62bf2@roeck-us.net>
Date: Fri, 24 May 2024 06:53:16 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
From: Guenter Roeck <linux@roeck-us.net>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <eeffaec3-df63-4e55-ab7a-064a65c00efa@roeck-us.net>
 <CADnq5_NmKyTBbE6=V+XdEKStnjcyYSHyHqdkgBen4UhPnVKimQ@mail.gmail.com>
 <CADnq5_Ndzw5Gre=yyPKyFNX5yFWjTCMg2xqrn6tEj6h8t-nAYg@mail.gmail.com>
 <1e088782-418d-41e2-843f-b3d6cd3ab4f7@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1e088782-418d-41e2-843f-b3d6cd3ab4f7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/24/24 06:43, Guenter Roeck wrote:
> On 5/24/24 06:18, Alex Deucher wrote:
>> On Fri, May 24, 2024 at 9:17 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>>
>>> On Fri, May 24, 2024 at 5:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Fri, Mar 29, 2024 at 12:18:28AM -0700, Samuel Holland wrote:
>>>>> Now that all previously-supported architectures select
>>>>> ARCH_HAS_KERNEL_FPU_SUPPORT, this code can depend on that symbol instead
>>>>> of the existing list of architectures. It can also take advantage of the
>>>>> common kernel-mode FPU API and method of adjusting CFLAGS.
>>>>>
>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>>>>
>>>> With this patch in the mainline kernel, I get the following build error
>>>> when trying to build powerpc:ppc32_allmodconfig.
>>>>
>>>> powerpc64-linux-ld: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.o uses soft float
>>>> powerpc64-linux-ld: failed to merge target specific data of file drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o
>>>>
>>>> [ repeated many times ]
>>>>
>>>> The problem is no longer seen after reverting this patch.
>>>
>>> Should be fixed with this patch:
>>> https://gitlab.freedesktop.org/agd5f/linux/-/commit/5f56be33f33dd1d50b9433f842c879a20dc00f5b
>>> Will pull it into my -fixes branch.
>>>
>>
>> Nevermind, this is something else.
>>
> 
> Yes, CONFIG_DRM_AMD_DC_FP is enabled in that configuration.
> 

Also, the above patch does not apply upstream; the endif is already in
the correct place in the upstream kernel (though the commit introducing
it adds a blank line at the end of the file)

Guenter


