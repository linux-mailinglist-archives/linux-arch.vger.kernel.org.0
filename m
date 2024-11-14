Return-Path: <linux-arch+bounces-9105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480419C9618
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 00:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA6E1F21567
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F51B0F1D;
	Thu, 14 Nov 2024 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GHXvQZ5E"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E518E029
	for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627050; cv=none; b=WJ95OPYRZmu6H3ZavdiM4USNcZLB4Su0w5K95Qll9pLEnkEnHL/ChzprM20hscrQML662NayqUScJ5dMby9z7v2/pEtB/J9ijW3X/MwcrqrkYXNcy+M+1jCgDeSTfJnzeFXmfed6NpInYbWyDGXOlkmZR2J2n2XhfyjSJ3HSoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627050; c=relaxed/simple;
	bh=vxicDCwwBRiP0DMDGHRnV2PAwpSDNUHcp5Qn2QCpoQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyLzS4XxgQFTbULCpm7bFuUowVGZgaupBWHa6s6QU+YuupiGqZSgKVeaL33mbmBwUtxXpfrK8qwhWvLlJzZWn45L3/XXwat1ooLKnL6HcVMPGKTOJcXJSUWk9NJa1fV5rscfhCV+r2YNou0l8G4RTaO//7DACsh1T/vTusQ3uEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GHXvQZ5E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb47387ceso13806365ad.1
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 15:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731627048; x=1732231848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vxicDCwwBRiP0DMDGHRnV2PAwpSDNUHcp5Qn2QCpoQE=;
        b=GHXvQZ5EcRSzWmiU7v4cSH0EQAZCjkxHwQKG/17gLyhrV+RUXRAoujmTz4O8zoyuIj
         c4nzf9jh0GlM5vBJ35ZYjWXhPdQ6IL4Mcn86Ck/uJaFY1ktrxfpngdz3ERzoayJBCQm/
         WJZGvohJ0XiMPwaFdEJu62ncxT1P1yq4e0baPfDuaAfhYeVboEPF6sI3OUOVJODlTRD8
         diaQvsmIrt5Vnj8ZENB9h9B9eKnYYb+tVFkNY53e1/Fe7Cp8t2n86C1Bn+lY2mpOGXUZ
         i46w+o9FfIcfzajcKWTgFlO4t0ym2erRD85KCooitIhG8W2kAbPmhdPcrNFvksJYDCe9
         L1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627048; x=1732231848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxicDCwwBRiP0DMDGHRnV2PAwpSDNUHcp5Qn2QCpoQE=;
        b=VJkjnlHhAmNkZYbRtqQgNGGG4FSD8VdQxX13S0MH/u4g5Bv882NDuY8G+BwKEkIsZh
         ek10O6uLUpWK75Qu2VGsngaXt3IzxqEKFc1jmxWCbvhEkuL7r5cd34TNne8Qbx29kt80
         IGZYE+B0L0HctAInaxz4M/wZXZkIU5x9NDmQoWtJ97AN4WmpUqeockJ5SrVuUUhwjhYj
         od1gg1sNUWW34qZluhu3X0e59xhMb+nJq9fy7A5ndSx21lDBKmX1/CgKNSkNVWGOXtxp
         Dp8YRoPUV7zegr0OwYZNXgPgKj8EDwm0cRHkMmfVwG7GP9bPyu8P/w07nguZZJNVS/FA
         a26A==
X-Forwarded-Encrypted: i=1; AJvYcCUBYsd12HrvBmROUohVDQ2VYAEsOfxf5eoFtscRkVka0+fY4AflgAPRjpfHveW86FZPBczUekyjHTLO@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSVwRp1Vfalm768a7snypEoymwUvkRU+Qn3AAGWgRVmH2u++n
	JK+02qKisPjVXCyuYY4tIQ8k+gXDo0OYXDBxtH2+5pbWGNcL+7p3SKP8+G2O5Cw=
X-Google-Smtp-Source: AGHT+IFDks2EX+J0Xcdhn+lsWLEpN9wIiMxHabG5LvqhYxnSDvigTX45SfsQ9L3weaXZQ650igdt4A==
X-Received: by 2002:a17:902:cec6:b0:20c:c704:629e with SMTP id d9443c01a7336-211d0eed4b5mr9426095ad.56.1731627047846;
        Thu, 14 Nov 2024 15:30:47 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e2c17sm192184b3a.160.2024.11.14.15.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:30:47 -0800 (PST)
Date: Thu, 14 Nov 2024 15:30:45 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Message-ID: <ZzaIJQXQprUFn3k4@debug.ba.rivosinc.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <20241016-shstk_converge-v2-2-c41536eb5c3b@rivosinc.com>
 <7109dfcc6df5a610dcfe35a77bb7a84f8932485b.camel@intel.com>
 <7f392b4e-9970-42d4-8204-2aa967a5375d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7f392b4e-9970-42d4-8204-2aa967a5375d@sirena.org.uk>

On Fri, Nov 01, 2024 at 10:39:15PM +0000, Mark Brown wrote:
>On Fri, Nov 01, 2024 at 09:50:27PM +0000, Edgecombe, Rick P wrote:
>> On Wed, 2024-10-16 at 14:57 -0700, Deepak Gupta wrote:
>
>> > - * The maximum distance INCSSP can move the SSP is 2040 bytes, before
>> > - * it would read the memory. Therefore a single page gap will be enough
>> > - * to prevent any operation from shifting the SSP to an adjacent stack,
>> > - * since it would have to land in the gap at least once, causing a
>> > - * fault.
>
>> I want to take a deeper look at this series once I can apply and test it, but
>> can we maybe make this comment more generic and keep it? I think it is similar
>> reasoning for arm (?), is there anything situation like this for risc-v? Or
>> rather, why does risc-v have the guard gaps?
>
>Yes, for arm64 you can only move the pointer in single frames so a
>single page is enough.

Yeah on risc-v as well guard gap is expected and single page is enough.

I removed this comment from here because of x86 specifics. I can make it
generic, do you think it belongs here or the place where we define
VM_SHADOW_STACK?


