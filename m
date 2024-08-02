Return-Path: <linux-arch+bounces-5908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C579459B0
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A01C217C8
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155181C0DE1;
	Fri,  2 Aug 2024 08:14:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D1219FC;
	Fri,  2 Aug 2024 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586471; cv=none; b=l46FovOZ7+QJsZodReI8Fx8izWnJp599VHThLn3TW1j8ENtDZUAICtiAx3tOzf6denuAH35vH8+nTPsITuxxBkFl2bwPwaMTpWVkkLbCnz/NWk6HEIPg1cuAUimZX5csRLOeZsbeAkWiT7t/vMN6cxCqwCDGa9j31mGNXJk6YjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586471; c=relaxed/simple;
	bh=A0nrEwtqwClmqH17gpGOwG5z3uDm/FSx7t3TcL0aIgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPuTJeBh/4PDPvokUGdCvxVgAKgRv7EhIb6prGNay8NNDDarC865/iGoVV4oKwa0He1vK5dfXCjSVgVyOcbpgtrFs2cvq9YjyK0Nkk/xxRL/SrxLvVyiGhbsxWB7XLasw5/XeMlcZIjUMRKmfAJ86v0Tf8IAb0Cr+I+WBJ90nyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FA65E0004;
	Fri,  2 Aug 2024 08:14:21 +0000 (UTC)
Message-ID: <4b890910-ed3b-47e1-a895-48ae3d47e958@ghiti.fr>
Date: Fri, 2 Aug 2024 10:14:21 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/13] dt-bindings: riscv: Add Ziccrse ISA extension
 description
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-13-alexghiti@rivosinc.com>
 <20240801-unlighted-senator-cc60d021fe28@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240801-unlighted-senator-cc60d021fe28@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Cono

On 01/08/2024 16:44, Conor Dooley wrote:
> On Wed, Jul 31, 2024 at 09:24:04AM +0200, Alexandre Ghiti wrote:
>> Add description for the Ziccrse ISA extension which was introduced in
>> the riscv profiles specification v0.9.2.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> ---
>>   Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> index a63578b95c4a..22824dd30175 100644
>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> @@ -289,6 +289,12 @@ properties:
>>               in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
>>               riscv-isa-manual.
>>   
>> +        - const: ziccrse
>> +          description:
>> +            The standard Ziccrse extension which provides forward progress
>> +            guarantee on LR/SC sequences, as introduced in the riscv profiles
>> +            specification v0.9.2.
> Do we have a commit hash for this? Also v0.9.2? The profiles spec is a
> crock and the version depends on the specific profile - for example
> there's new tags as of last week with 0.5 in them... The original profiles
> are ratified, so if this definition is in there, please cite that
> instead of a "random" version.


That's not a "random" version, please refer to the existing tag v0.9.2 
where this was first introduced 
(https://github.com/riscv/riscv-profiles/releases/tag/v0.9.2).

But I'll change that to the profiles specification v1.0.

Thanks,

Alex


>
> Cheers,
> Conor.
>
>> +
>>           - const: zk
>>             description:
>>               The standard Zk Standard Scalar cryptography extension as ratified
>> -- 
>> 2.39.2
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

