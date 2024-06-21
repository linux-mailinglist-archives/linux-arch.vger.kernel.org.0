Return-Path: <linux-arch+bounces-5006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8149120B9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784ED28193C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B9416E885;
	Fri, 21 Jun 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjIEVOqY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C1316E87B;
	Fri, 21 Jun 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962483; cv=none; b=g068VrHf4QdsHfOgIT9pPFopPI/uR6szNQZY555kjLGczJZaJfnwaVNPYB1RTKt3Btld54xYWB8Af7mWrr0OBOAUBXVk14Gj/OMsfzfjj/3HGjsVJibtPnmbXgCM3aYG4K0m2b+iAC/VWVtcfz6Yw9KnQw5sbGSLnPlozLyrrLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962483; c=relaxed/simple;
	bh=jE51PnV5EwBj2vUe72KXHFR0KLjv+PHhidQiOR7Tnrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvLo7V0/K6uLequZkIoHcT3JBbPkarCGwe7r0OV8VnuDS4AnFP/mXhIc4xu75nFGOxtDktTTIHkCgUDPDWfbykYUiM+AxiMBIDydd75LvthB0sn7FTj9ny6wHLT/rL2p3x8rNsvCiqmfwMv3onuGEfROFPwE9Wj0MCrw1dazT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjIEVOqY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7062c11d0d1so1650502b3a.1;
        Fri, 21 Jun 2024 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718962481; x=1719567281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOfOHGWM85MYwLzr4mYDa2Z5BOkt2sOF/968G/m/mOk=;
        b=IjIEVOqYOmV0lYcNd2teDTYRCSM/Y1dj7EvnJ9BUm+6zUpgtS+A5GbfB848ZghllpQ
         XwUkpcDMHdil5ugFacDBSFr2lR4UIAgbevafYklg5pS5YYX9FYx5T9tAI9FJIYW+kxuc
         T4tpZs/OUwUcHAptZWB3Qb36haLfIdvb8DlSGeek94SJJtAFJccxPmvnjBm/3NKuYul/
         s5HTik9mc6a6o97twqtJdC8oQBxE06zXC/iu09H5UlSWQP3/7h6CBVnd9tJ9TqaUXpfF
         f4pIZzjOdEYOjnqAHvJjSGhpn+yClybriVVj+6MCg6ZVtptfepV5S8sNIGbxprinIXRV
         5s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718962481; x=1719567281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOfOHGWM85MYwLzr4mYDa2Z5BOkt2sOF/968G/m/mOk=;
        b=DAZhpBW3/kznz2zygAG8PVDpFg+2ChAG4/5Q94+rLAxSj1gbr7eUtusmfbWicHk6jI
         +7IqPNOvbVSir5k3a1/PleOLiurt25sgoyoaiaUOi/DZcaN8HDm5ND/VoroVzuoegcdN
         rvzydTxpKUEeoaqMhn6EFOhMrgEEI8rrOo88aOGzATa8C4plV9tgorQIYdZF/++EQtus
         4G9EmAg/+xfC/3mshmPpf/RvTCQHRTW6M1dfpA5nf9oCv1QYDxeEqFgya3bXpERPbh4g
         3f8THgtd1/2EXWkGfoqJIpHotrAKdajfwx9e8E/5ZwF/a4gDqsdTRpo+lJA+VIyQNBqc
         Ap+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3xJbsUlwUGwxm5jCIE6k/ZCW17Xd7z9Ab2jHCu6xN/aYvDZ01I8zfePf5mqS1XoD3wdHondoyUqq/l5f2NS6LZ8CdplTjBfOEq3a2JL3iXLv031u62WEPntNsO5LVvLBo1b9rtCetIA==
X-Gm-Message-State: AOJu0YxtlUWjezLituTNe5PMpbuEbjdLuhcyUgGj4Mz0/jsZ/rsHWK4Z
	kTB3aV9VvPuCypedq78d4i+TT8fRVb8/O/ZyUvcNeni5k0ZlU2Ut
X-Google-Smtp-Source: AGHT+IEeUxGDTwGB8VosTpIA20i9Q6XpmX/CnHOXS1fPPKScq1Qt8Sxnlk8mQiGfdUjlvHa1IOVBRg==
X-Received: by 2002:a05:6a20:c412:b0:1b6:63b6:ea6d with SMTP id adf61e73a8af0-1bcbb39ff23mr7701203637.11.1718962481510;
        Fri, 21 Jun 2024 02:34:41 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512e64afsm973769b3a.189.2024.06.21.02.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 02:34:41 -0700 (PDT)
Message-ID: <64f00fbc-5bcd-439e-a0f4-94f35e84e5ec@gmail.com>
Date: Fri, 21 Jun 2024 18:34:32 +0900
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH lkmm 0/2] tools/memory-model: Add locking.txt and
 glossary.txt to README
To: Andrea Parri <parri.andrea@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>,
 Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Akira Yokosawa <akiyks@gmail.com>
References: <ae2b0f62-a593-4e7c-ab51-06d4e8a21005@gmail.com>
 <ZnU4gE+OB+xvvW+I@andrea>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <ZnU4gE+OB+xvvW+I@andrea>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 10:23:28 +0200, Andrea Parri wrote:
> On Fri, Jun 21, 2024 at 01:08:24PM +0900, Akira Yokosawa wrote:
>> Hi all,
>>
>> [+CC: Marco, as Patch 1/2 includes update related to access-marking.txt.]
>>
>> Looks to me like Andrea's herd-representation.txt has stabilized.
>> Patch 1/2 fills missing pieces in docs/README.
>>
>> While skimming through documents, I noticed a typo in simple.txt.
>> Patch 2/2 fixes it.
>>
>>         Thanks, Akira
>> --
>> Akira Yokosawa (2):
>>   tools/memory-model: Add locking.txt and glossary.txt to README
>>   tools/memory-model: simple.txt: Fix dangling reference to
>>     recipes-pairs.txt
> 
> For the series,
> 
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thank you!

> 
> I do get some "trailing whitespace" warning, for patch #1, you might
> want to clean up when applying/reposting the series.

Ugh, I failed to setup a pre-commit hook for this repo.  :-/

Will send a v2 in a couple of days.

        Thanks, Akira

> 
>   Andrea


