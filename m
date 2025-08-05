Return-Path: <linux-arch+bounces-13064-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D188AB1B170
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 11:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C6F179D24
	for <lists+linux-arch@lfdr.de>; Tue,  5 Aug 2025 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2E26CE2C;
	Tue,  5 Aug 2025 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FR+GmjLZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434726C3B0
	for <linux-arch@vger.kernel.org>; Tue,  5 Aug 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387410; cv=none; b=Uif7LD1XFtN40IPMOfNKuoKPVxs3wjqcBhQQhrIQPIpVi6hJQaBEEGKOCu9+lWlt+9W8lajjbliW+emNOZEACuru9v9JmXERJcD8lKg0zM5MsNg3hYcZ+IJbzX/k1ZrsdTS9qgTpnOito7C8wXmF+j2541rH+v6iaBBdQ7/oyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387410; c=relaxed/simple;
	bh=nCfaEyH7MqXv+EacNelojLk+r3n+1Ey4CWEaurdGut4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZbwg3zHTwHISsXyGXshGGLyKWAf4USHk26G/v//txRly2CTP6hStoejyPeM3M0NomA1tzr0fzIJm3uxZKilMxHUs7actpY/3HZHl0Q+0JSLvPahmEAKAhpltLUmQp3z3gvMIIBRuYom0qGk7G6g3h57+cdeVNGCzMWV+C7s6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FR+GmjLZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754387408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R3Nw7N9ZXr94BBw5pnV0yLMbnOotSy69DH7y+0p/p9Y=;
	b=FR+GmjLZpRanQoDjYB8ckynoKgXn5A7aLwu79aGJ1YkPzlNT8FvDVSwpWDGxRAvKCc5Dxt
	meKbaLE/hO0vBsqHri/RqYdLul+ZKvXyliIdL3PJVe+joSGuN7t2MICYqtWx3e2NW9B7aG
	PfRrWiOlgCRN1XddKVuof1gJefC60cY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-qjewYbMmORqAu_gfV_LQCw-1; Tue, 05 Aug 2025 05:50:06 -0400
X-MC-Unique: qjewYbMmORqAu_gfV_LQCw-1
X-Mimecast-MFC-AGG-ID: qjewYbMmORqAu_gfV_LQCw_1754387406
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073f12d826so115619966d6.0
        for <linux-arch@vger.kernel.org>; Tue, 05 Aug 2025 02:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387406; x=1754992206;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3Nw7N9ZXr94BBw5pnV0yLMbnOotSy69DH7y+0p/p9Y=;
        b=BXQx7bSEHmNOgtfcP2WLR6C0X0eT3fSQzormcx70AtrSVVDRULm5x6Q5WOtSdv2txQ
         GDhRC4ylTay2RQNFp5mC0iXqG6Li974MEZbg6EbawCK7ohttI3xOhOIw1Xci0fBEGVSe
         kxERWX8m09CVjlyRw663EK5s6WsV/jReelJwPE8+fVg0G7tfQU/HGwne7HO0H3tIKuen
         DJd51PDMlaqjL915x2PwZUlDtcDwS4JNWSPvj4MenjMNs8NoXjMR4YdOa06caViSFKhA
         wEK3Dtz5y4j2JwjB0ZBK/DvDL/lXnM8svaUuJUI06cxTnylSFZIexPQAPSBZraI6yJMj
         DK6w==
X-Forwarded-Encrypted: i=1; AJvYcCWEV2chSqVDYV8L46vnKuEL1CyzOcO7Pi0J5cOSpTj7eA1U+Zu8zhRGQHKmHeGMxzSEGPDqpXkvv4s2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LaDQ4x5w3hzoq99JwCI+UZ3dapYgW9q9TQDUizGdyWV7Zp9q
	YY34dZGf1GbWtHgn+r65ZW4gUarVz+0z7z7XUY0ODOEfcP77LV4GsossWsVezSiYcVnfVq2UK3l
	iqrYgybsMlv74yN2irMeV7h75ktUOYZdEedm0NKFR/B2uwFalLdStUjnK9J+f2QQ=
X-Gm-Gg: ASbGnctmLVDxicQkaGIiuORPjytsgZ31eGSm7n+1inja+Fw7ZW5tP+M9rQoeqnB5PwW
	djLeOAC/MyrF/BFX5TSiO5+3lvpE0w0d8PPDr5vZXV/ljhRfoeyGf+B521btLkbqVmz5VZnVKgi
	ZsnZr3rbuUVQG3N/SOrQk54OGFnbJyNc5LmVwjVqGRmA3PIdMabKXQlcx5R1X6InZzNxY7T9NGK
	pe7Vv6Sbi8n8QR6wBPJufKbcTgo8o1uAtLDsMFKrHMjg5AyPuNSRV4vEeBY9jEDZ7jruFDaBetR
	GIHLMdeQY7Arg4C4Nq+CWEMzhKvEBgQJsSYi3b+McLT1BTyQ2qPB7uc8s94EdxR3
X-Received: by 2002:ad4:5d47:0:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-709365356c5mr196606856d6.16.1754387405961;
        Tue, 05 Aug 2025 02:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyx5UikJMmenj3I+DsKP/39+YkgKQdeXVza/ikYs70+jG1oaF8F4CiNJdzGsonQmcA7J7Qkg==
X-Received: by 2002:ad4:5d47:0:b0:707:5c4f:f0c9 with SMTP id 6a1803df08f44-709365356c5mr196605396d6.16.1754387403253;
        Tue, 05 Aug 2025 02:50:03 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cea1782sm67866596d6.93.2025.08.05.02.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 02:50:02 -0700 (PDT)
Message-ID: <bfb22382-c513-4135-9e24-dbf7595dbd72@redhat.com>
Date: Tue, 5 Aug 2025 11:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-35-thuth@redhat.com>
 <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <5d9ab8b51a3281f249f514598c949d2c9ca6d194.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2025 15.33, John Paul Adrian Glaubitz wrote:
> Hi Thomas,
> 
> On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
>> While the GCC and Clang compilers already define __ASSEMBLER__
>> automatically when compiling assembly code, __ASSEMBLY__ is a
>> macro that only gets defined by the Makefiles in the kernel.
>> This can be very confusing when switching between userspace
>> and kernelspace coding, or when dealing with uapi headers that
>> rather should use __ASSEMBLER__ instead. So let's standardize on
>> the __ASSEMBLER__ macro that is provided by the compilers now.
...
> This causes the kernel build to fail:
> 
>    CC [M]  drivers/gpu/drm/nouveau/nv04_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv10_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv17_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv50_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nv84_fence.o
>    CC [M]  drivers/gpu/drm/nouveau/nvc0_fence.o
>    LD [M]  drivers/gpu/drm/nouveau/nouveau.o
>    AR      drivers/gpu/built-in.a
>    AR      drivers/built-in.a
> make: *** [Makefile:2026: .] Error 2
> glaubitz@node54:/data/home/glaubitz/linux> make
>    CALL    scripts/checksyscalls.sh
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>    AS      arch/sparc/kernel/head_64.o
> ./arch/sparc/include/uapi/asm/ptrace.h: Assembler messages:
> ./arch/sparc/include/uapi/asm/ptrace.h:22: Error: Unknown opcode: `struct'

  Hi Adrian,

could you please give it another try, after applying this patch first:

  https://lore.kernel.org/lkml/20250805092540.48334-1-thuth@redhat.com/

  Thanks,
   Thomas


