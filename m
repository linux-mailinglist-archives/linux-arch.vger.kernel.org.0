Return-Path: <linux-arch+bounces-9103-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F29C95FD
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 00:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AE1282894
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 23:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7721B21A4;
	Thu, 14 Nov 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AKc1qltn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520871B0103
	for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626146; cv=none; b=Eb3bs/mopq419vM/dcBmHFgxBrOMubx56xAnCoDE3SJlaQIkaeauHGkDnZPZ90jhtw3T7WfXN2qgDQr2o3GuLeYPYfIJGRXUMD2SU+UR5Utcr3cCLU7m2b4gZUhukgYgvuWkYesEo5clKrCjeHWdU21JnnBj/LUYYboRrHc095E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626146; c=relaxed/simple;
	bh=lVsLA+ch5pK0Ivhr1CMOYtJ6HXoVJIzTUjCvpU4nqRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLu11LwR8djshnqauESJy0JotisJza+Pa1Ch+tzyGeqR/NTiFUTC0OBSG/yhtWv4NtUnnau+tPrUHyQiIK6M3B45j81qVEwtRW9uLQskOvoZSIRkVBnwufZ3Etpn2gvKGij/DMpBDxVsXHTMeTJTI0c5Gj0hw/cB9BlpsWHWuOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AKc1qltn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2113da91b53so9112415ad.3
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 15:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731626144; x=1732230944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVsLA+ch5pK0Ivhr1CMOYtJ6HXoVJIzTUjCvpU4nqRo=;
        b=AKc1qltnrvqJ3RV1sciU/yD9J/2xmLdJdE4E9a8TMND9eYd70jSxy8NWG8ak6vj8aN
         tEJiKVfUI7APwommSlGZVarC5FYD1KhMdITwQfBsOrWkAVG86SlLcH57lt0zhwyDXP/x
         6iRngkI13Nd6W9NbMpiypfukkQNFcJ60W7plw2VTGch43yS/ZFKyrqUbtmFOTXZu7hGl
         FlKBHYepfLpGtgx9WCIoGiQbIx1zSbg7s2bqQbRMxK3n7AcDlkHe46MX0e/nZrLOpPGP
         Pku8LmvgcOvYiNo1uL9GJJzCCbVOP+FLc48mdJLfZpazc0xAvLZ40vQ1UqxHIKlcjqsn
         7/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731626144; x=1732230944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVsLA+ch5pK0Ivhr1CMOYtJ6HXoVJIzTUjCvpU4nqRo=;
        b=IscfjTeboeRAZSQvtwmU5ALoZKkhMtIJ4xi/mIzDszSIwyUv+UbWYn7+R0+b8KYZeA
         lJ2+0s7Ph3gAjvb5iIibKzL/IEqBl6yf3HEIf9WviNFDkzubUODCNGC3BTnDDjxzpgXu
         x5XnkASJJSpPLi/nXIpTunV3EO5vIrd/FTAaPKXaEvJZjWy153/kqR8yHMZZvR7QAk7L
         NHakxPVk55FQcP8TQecfVOThLGPs4BhbjF8LZcT+MwAZapOkw/BI1XwdbvxvfyFvIL2J
         BOuvBmU707XKD4XxTdrZeW9Y6TJU/8dpKk4SC8uXFcJrIc7xVxb3HViyGG2narPph+Rx
         IWiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLkybj/COrU0IYIsZcBcucxMNzW9qmboWdT+aGSvEQZ5x63J5wghdaXwiwkUNDJe+z898SHL4+YHTX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9jN+Oma3Gr2EIB8vd40NYHyNroSN0hfPjNpkINN5L5Zi5/7P0
	wePG0wqaV6++aSnyYu8naSdRSnRru7Tp9L5iI+lX7JW6Io3Rbz0aTKIj6Ku/O6I=
X-Google-Smtp-Source: AGHT+IHndwCh8OZviLWwqtdRGD5ZEaLmwdtieo9Vt9MWEDHtv0+lyZ2wfaF39f+wWy1RScC9FPlXYg==
X-Received: by 2002:a17:902:c407:b0:20c:9e9b:9614 with SMTP id d9443c01a7336-211d0d725c2mr7977755ad.15.1731626144617;
        Thu, 14 Nov 2024 15:15:44 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc30a9sm1690215ad.47.2024.11.14.15.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:15:44 -0800 (PST)
Date: Thu, 14 Nov 2024 15:15:41 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
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
	"broonie@kernel.org" <broonie@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 0/2] Converge common flows for cpu assisted
 shadow stack
Message-ID: <ZzaEnVpBUhZsp7qB@debug.ba.rivosinc.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <964caf1797be61001901b92e3b71259443d3196f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <964caf1797be61001901b92e3b71259443d3196f.camel@intel.com>

On Fri, Nov 01, 2024 at 09:47:31PM +0000, Edgecombe, Rick P wrote:
>On Wed, 2024-10-16 at 14:57 -0700, Deepak Gupta wrote:
>> ---
>> base-commit: 4e0105ad0161b4262b51f034a757c4899c647487
>> change-id: 20241010-shstk_converge-aefbcbef5d71
>
>Where can I find this base commit?

I am sorry. I picked up Mark's "mm: Introduce ARCH_HAS_USER_SHADOW_STACK"
locally and then created patches.

Should have rebased with arm64/for-next.
But for that as well base commit will be on arm64/for-next.

You can apply "mm: Introduce ARCH_HAS_USER_SHADOW_STACK" on "v6.12-rc1"
and then these patches.

Alternatively I can send a v3 with above patch.

