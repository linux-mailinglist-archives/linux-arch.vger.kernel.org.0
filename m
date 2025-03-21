Return-Path: <linux-arch+bounces-11033-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA0A6C43A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 21:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5797A7AAD
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150712309B6;
	Fri, 21 Mar 2025 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="l5o0kxHw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28081230277
	for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 20:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589050; cv=none; b=shLB9xZDB+SkGd7I6SG3vad2clWt7VnFV3YRpFqlnkLIWq5mFQTUxmdmxzpZQ73F+2mxpX5qG9fCSua/EHdm+d6U5fF341RfV6/Jn5H/naxhL+MPfs60aZNLV7XenRDdEauX6otT5idTgZRdU/IIHYmsGCEoom7+m+IGUXOv0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589050; c=relaxed/simple;
	bh=kufjJ7ROxUIeeWBTf87pHaUYN0P9yN6f9l3gagdcYI0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRXGjBZ+T8eja/6tA9EmVZOJFI6XYt3gW6V1B6afk2IxmJjRCpKTjvihsBHAB5IBk76uBScBfecincPzbiC4ytU8Nu8LZfffz78VhQgTYvX3PB0YZZUcrhOBKuYh7iymYQoWRd2kAVvubUe8i9jrSAFDQRVeegN5lccYU+26DjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=l5o0kxHw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224191d92e4so49195725ad.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742589047; x=1743193847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=l5o0kxHwz56/APvSz0yxxES3DtKjkGRzP3aHJgNtqfsPTeXBNyJqn9VNgMK3W6VEgd
         C3QYN/SUg1QAF8O7bGci/PkW/6tvRBw+3iE/xpWr29FsLghzQGbm9S5Ud3iooTfeENXt
         V1W51rg8ZwyivdKhNuOGhhAQIyBNtmn8MsF/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589047; x=1743193847;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/gNIM+yOS6xUSJi/6mY04tkW5DVweXdgmtDBLblehc=;
        b=KBPTuUr2/MMFYKxXD3nDPjMnEV6S0rKAy4JNG4i4UF17qGfIdXY7cW3Nkg9wA+m5/u
         t+HY8XSTpeoasinwgOexJyvLkbhRsBnsz//ORBgTv8EyIDjTDwAJAuzpluTW7PQW4TSm
         7XbnWzXYtBZ+Itjv27NzRt7bcAMmkKq2gIg2mkiJDFSu1kMeft+JXnpm/EIJZQyigEBp
         RD/EtTlxLgBybYHgpWf5Ga9mJKZZ3i7gj/aVj0djZxC+YWMdev4/cghVKOuOEH7kqWYF
         7WkHtv1UGcYTAk3eHUeFcmKkIsBR0AddNURFEdQDW0HpPFZTuNq5he5RKKVITNGCR1u3
         vBRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWWtm92Xi1quEPRiGri700OKEHRdhQ2oBRRd/KLUXfcvKluz99S+mP28ZeRhLw2uN2dpcYLpVn8sl7@vger.kernel.org
X-Gm-Message-State: AOJu0YwFii6RJcuxOxa7ottAYx2BH9+So0CV0kS21nxSujmwDA2+GpME
	VVhWE0U69/6zxASJmPs+xVd0aIwhbfZJ0ILooQLSKYp0L5ozPNSPfSuuajukpuk=
X-Gm-Gg: ASbGncvtzM9rlWinAeHf32JzrQ68NFL22u9mCHcEMjw3xk0ScicowcER57s1CEa5e5g
	T5Qg4zlZXTs971VkB+jv2vvH7j50qPCDfIl6etD9S+0zXb3rn1sZIykxNf4AUDExW3Jewz7pBHI
	LY31254SWxse/nppQqiqOkDtipQK0W2p3HExWW0oA7vc5D1DBg3bsouU42b3HTxU1vHrXp1obY8
	JfnDdJPHXfHo5V37c1a/7WN/zv9vRuzb7Q1XXNtAQFJsfWEEunzonD0eEGpbXJZOn/1kDqPs6Rx
	Q80AKoSI7N/P88QUYAT2vlO2yM0fOlacPLdr/BSnMBfQlTYKQ3JbS3x5l9XgtK4BWJ0y3FCCYsA
	SftgsAJygEY3NdsTP
X-Google-Smtp-Source: AGHT+IE/0vRvWUIrCU9TpLfmE4aooUPQeYEWA/MrsW2UXdaB42a9j/XwGhSTptf5SM5XxL22FRt0Ug==
X-Received: by 2002:a17:903:41ce:b0:224:10b9:357a with SMTP id d9443c01a7336-22780e3fbabmr64649685ad.32.1742589047213;
        Fri, 21 Mar 2025 13:30:47 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2aefsm21875045ad.109.2025.03.21.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:30:43 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z93Mc27xaz5sAo5m@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, kuba@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com, arnd@arndb.de,
	brauner@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de,
	jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2>
 <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2>
 <Z9z_f-kR0lBx8P_9@infradead.org>
 <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
 <Z92VkgwS1SAaad2Q@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92VkgwS1SAaad2Q@LQ3V64L9R2>

On Fri, Mar 21, 2025 at 09:36:34AM -0700, Joe Damato wrote:
> On Fri, Mar 21, 2025 at 05:14:59AM -0600, Jens Axboe wrote:
> > On 3/20/25 11:56 PM, Christoph Hellwig wrote:
> > >> I don't know the entire historical context, but I presume sendmsg
> > >> did that because there was no other mechanism at the time.
> > > 
> > > At least aio had been around for about 15 years at the point, but
> > > networking folks tend to be pretty insular and reinvent things.
> > 
> > Yep...
> > 
> > >> It seems like Jens suggested that plumbing this through for splice
> > >> was a possibility, but sounds like you disagree.
> > > 
> > > Yes, very strongly.
> > 
> > And that is very much not what I suggested, fwiw.
> 
> Your earlier message said:
> 
>   If the answer is "because splice", then it would seem saner to
>   plumb up those bits only. Would be much simpler too...
> 
> wherein I interpreted "plumb those bits" to mean plumbing the error
> queue notifications on TX completions.
> 
> My sincere apologies that I misunderstood your prior message and/or
> misconstrued what you said -- it was not clear to me what you meant.

I think what added to my confusion here was this bit, Jens:

  > > As far as the bit about plumbing only the splice bits, sorry if I'm
  > > being dense here, do you mean plumbing the error queue through to
  > > splice only and dropping sendfile2?
  > >
  > > That is an option. Then the apps currently using sendfile could use
  > > splice instead and get completion notifications on the error queue.
  > > That would probably work and be less work than rewriting to use
  > > iouring, but probably a bit more work than using a new syscall.
  > 
  > Yep

I thought I was explicitly asking if adding SPLICE_F_ZC and plumbing
through the error queue notifications was OK and your response here
("Yep") suggested to me that it would be a suitable path to
consider.

I take it from your other responses, though, that I was mistaken.

