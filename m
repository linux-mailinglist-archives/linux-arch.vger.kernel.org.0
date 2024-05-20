Return-Path: <linux-arch+bounces-4467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79928C98F9
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 08:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9732817B7
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 06:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE112E5B;
	Mon, 20 May 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SB/u7ulb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40514F90
	for <linux-arch@vger.kernel.org>; Mon, 20 May 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716187513; cv=none; b=aDwQx0Q2xIMeeuXs2HYvQ/Anj6UWHy4QyY/1OXLEIWqwMmCDeLL3xP00IqvlOG3sTZsV8ElcVSVX5DMALK1DGjL/PkeEay2RePMbLcRhlrNjxgQ1hkObKiFJmL1MBWLkjefM0yDwemQlmHF5lzB+vQPY7+euVctViUYnsnFLG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716187513; c=relaxed/simple;
	bh=hr75UYv2qEd7xP77FZGkKrnpVYDdbRGTw6NR1qgODD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kg/tC36YBxG4PyHdR6OhenAIam1iFd5Z1xX3eMohR+doXslk3m6ghxhpKFonps4eri3Nlmewz3zHzlBzXz36rzLpKVq+3RFqspgITw8cRslB8poyH3aRG0wT7U/HgP5Z0NTXahe4zqn6Xh4mrDNp7ZfTL6rl6mE5NIlTovc1b5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SB/u7ulb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-574d1a1c36aso6817356a12.3
        for <linux-arch@vger.kernel.org>; Sun, 19 May 2024 23:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716187510; x=1716792310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0V+uNbmY7tN3qWcpBZkwWLP1qbT3At4MWvLMcy0LGI=;
        b=SB/u7ulbCsvRA+e/9nRqenVZ+XOF6wc4OcyyAqdNFaCsxPiA/yqxxMBACbJqNWylch
         PP6fDvAxGAdsPAQ5ATr/JtXf53kAjrwXj8nVddMNXQEQPQtGXTr5yQ3NHJ4KEBeqkofA
         ZNckKAWalUJS9JwpE24VS/SslyjxAxfd+QhJz5zRrovkfTsic5skUHYqhIAm6Xovq+eX
         HR6nmAiouS9enEUuPHJjNefBtpt0q/Uuc7u3Pb03rkDclXxUh/co5/Wd+7WA3ZuGrJzJ
         pXHTKZu/1HakUq8a+EjHenHilMy6B1kPzM2NPvc6OFUyarnBuhZQ3SJtkrQmPJyFrZyV
         VzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716187510; x=1716792310;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0V+uNbmY7tN3qWcpBZkwWLP1qbT3At4MWvLMcy0LGI=;
        b=Jdtk7OaRnz784VfxWXYSbJnY6j2q3eExWwilDbPn031cCTiO6ZTCRAXJEl/r+gyUJ5
         Gm1fHAbvLN31zd7tL9IKUspcl/TUl3Mon6Cr3vG0+SBI0QD92AX0+S8jw8jab42B65Ut
         gmF6k2dMFAMHkVJU2y7OhjJmsWuo/RbljN6ka0/Vaxp+rx4cWmQoq/e60xn0t7a7xr2A
         51RrL2meAV/4k5qjefz+zL/W9Pp2c12FiOXpjJlcsLXdjeyb7Udxr19ufO/U3eMc/nw6
         1ZMuBAir1dAYt0aaKqLOTggpPjLL5FA/5zpTmDRPCS4rL9B/ToCApLdk7zaiaMzSPjGt
         acug==
X-Forwarded-Encrypted: i=1; AJvYcCWkWqYFtfaIIPrnP0FEcUBDgB++HJz7GE+G0qGPeJfQUrCsu5RU2SXxH86JPrcRQCr7wqSSsJTCCeBJiTqdGDA18LWuTxhYbuxhJQ==
X-Gm-Message-State: AOJu0YzvUDo1bXodHmD8dl1Zr0hMRxsRCYRnpHctjnbSFk1tX6vpu5qg
	TfnVRhXAgg8lhx0pZCoaiHP0uk1QCUPJ3MoLpawxcuZxyTFJ8IBPY9BAI1i85tY=
X-Google-Smtp-Source: AGHT+IE+M94sMH83nKSZvl+hRQsnPTVqUCqbFrz67EmAcoj5mw91+yZg8tOJqqQInLvtsbO5N5jagw==
X-Received: by 2002:a50:a6dc:0:b0:574:ebfb:6d90 with SMTP id 4fb4d7f45d1cf-574ebfb6e1amr9598442a12.4.1716187509796;
        Sun, 19 May 2024 23:45:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfcc1sm14224510a12.45.2024.05.19.23.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 May 2024 23:45:08 -0700 (PDT)
Message-ID: <6f7ae5e6-d20f-4980-9b6e-25ba6d7b5558@linaro.org>
Date: Mon, 20 May 2024 08:45:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64/hyperv: Support DeviceTree
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-2-romank@linux.microsoft.com>
 <1766fc9a-1d10-4c93-a9db-a7e0db8b01e7@linaro.org>
 <267ef0e2-2384-44bd-81f9-f33dda7bb9d2@linux.microsoft.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <267ef0e2-2384-44bd-81f9-f33dda7bb9d2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 19:33, Roman Kisel wrote:
>>>   static bool hyperv_initialized;
>>> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>>   	return 0;
>>>   }
>>>   
>>> +static bool hyperv_detect_fdt(void)
>>> +{
>>> +#ifdef CONFIG_OF
>>> +	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>>> +			of_get_flat_dt_root(), "hypervisor");
>>
>> Why do you add an ABI for node name? Although name looks OK, but is it
>> really described in the spec that you depend on it? I really do not like
>> name dependencies...
> 
> Followed the existing DeviceTree's of naming and approaches in the 
> kernel to surprise less and "invent" even less. As for the spec, the 

I am sorry, but there is no approved existing approach of adding ABI for
node names. There are exceptions or specific cases, but that's not
"invent less" approach. ABI is defined by compatible.



Best regards,
Krzysztof


