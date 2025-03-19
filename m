Return-Path: <linux-arch+bounces-10980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BA9A69CAB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Mar 2025 00:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36E642143D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 23:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBBC224890;
	Wed, 19 Mar 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Uo/gT6UL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB9224887
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 23:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426575; cv=none; b=acGhRGiaXfUJIdyD37dHuAqlUw436uAFarG1qAXFGTetROTfBND9USZmoiS4YSw/NDX0VUFCpgcXbDuew+s6rqY/L6WWi5jebGWAtfcR3wugTFNDMuPlQaYslwMxxzBBGTntc+v6ybg4PzfzENKNzDOZ0LU2rD0SWuKevdpEhVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426575; c=relaxed/simple;
	bh=ae9rlx1whGDKhagXiRxttetS8FA+ejbtaGjxWFoZyII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJdIT+HvmkHwn9/J+Q5Ji3L9NKO2Y3oasru7DU0pTXKnVISTAilxwcKQOwQdwJHjD6+2Ndh26tUZofWNWq8L8lFZKgOAT5dSKYJrVJn/U3lTUixzoHI92+/VRtPUKpBZyLk6wW2W4GrlxrgCnCzdWiP316kRGsQPFrBLiJdsGx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Uo/gT6UL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso2086626a91.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2025 16:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742426573; x=1743031373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdI4ujE7yE0oblUwCTVz2MCgqM4I0uuI2fAs3f/OjUM=;
        b=Uo/gT6ULuEnl2Z1/uveAtfRoE1fVAdSTR7KNfg02NzJUBuCk69NwWNTuYTYY4EEoKA
         1i4bd9slFzeLwmYXw10WHJ+sEiU+HbtqhowLEd32PTO2z2fKTJ4uJHB2Vt2cpZXSfuRW
         C70f8WGQP8dEdzGscD9E98qyq9JXa1iS+deRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742426573; x=1743031373;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdI4ujE7yE0oblUwCTVz2MCgqM4I0uuI2fAs3f/OjUM=;
        b=R9hfz8/tB/2K+Qxu59YMxJeaM1qm68E5PMXyZKqqL3uvsM1jo8lAznZQ2ODNWXErQO
         O/BgfEni4fqE4BiZkecuSotLwizKT06Qr2WYoQwJSN8WBhYWsYDQYDm1Le1NtjcHUOiZ
         duZmEKJnREmtPnMUe2x9KY0Cw5k9Pu2oOGmINoCAeNfbKVkW1lsrNqPx/vzlLIsBIgFv
         TbRiR9NXWlwUIVtVyfSCYlnTteqTV073g5EIpYmzz6uhWdSHtZs3jxxuEkCPUYHiRsv1
         ajf8Va7rVULXehpyq+ZbkMayxLNUC8wtLCH+4GkaHJyX7U7iH0D6RlIM1g4Fq7xP/Jf5
         v3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXuQpLTk8eLDGJin937WAYtYKlw+H5omgNZLW+bJfZ6OXykG+IS+hEG3lzulTFhK9ficdtUNJv/td+n@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAAhtJ+2g3mCthlbYMJqxnUhlyMfEG6iLAqX8d1JM2PEDw9+j
	S+xcvrPh0RMAPTt0jPZR28qnj1AoVcqAesi+YsUOM6F4yz9p9A4t5t0B9PmrLY0=
X-Gm-Gg: ASbGncs0Tf44fWOMS6vJOvuS2NuwvUC1gAKSSBumdLzg8dwvMRJ4X5zRKvHqetDb+h3
	Tqf5uLZf7zsk51wmLaH5TQU8UYaNtBrCSAqHdXQmI7B3a3hJpuMFPUUOuBRY6niXd62HUnPuUgm
	JUdfb9O5WRiDUoQjKK7HTrMdlLCrl+8v8A/JRqyIkGKw/TvWIRpbt8ZWQK9KKyIGgcsKBYRWPrT
	OWprh8g6JAReuEhCq8lUWptZ7nmC6rExkKvmUuBybZ83MqZxAAECNr2qL6QYq9v4+sCgmfBYlJO
	26mLpGcY3naIRP9UtwDZmqbWudlamg8Ddk8B6smW7zwAwCbVYl258RUa/oc+fH2Jhz/sRPhQGLk
	b393XCOiPVk40eMQk
X-Google-Smtp-Source: AGHT+IG2dHorZURvsBe8FbIvm9Ot+bVszEXfqj6y7gPkK29Cdkho8rVqZj3wc8miFsa8O6743/+MAw==
X-Received: by 2002:a17:90b:38d0:b0:2fa:30e9:2051 with SMTP id 98e67ed59e1d1-301d42b3a2dmr1795842a91.5.1742426573223;
        Wed, 19 Mar 2025 16:22:53 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301a39f1073sm3930726a91.0.2025.03.19.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 16:22:52 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:22:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me,
	mingo@redhat.com, arnd@arndb.de, brauner@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, jolsa@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
Message-ID: <Z9tRyeJE5uKDJAdo@LQ3V64L9R2>
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
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org>
 <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>

On Wed, Mar 19, 2025 at 10:07:27AM -0600, Jens Axboe wrote:
> On 3/19/25 9:32 AM, Joe Damato wrote:
> > On Wed, Mar 19, 2025 at 01:04:48AM -0700, Christoph Hellwig wrote:
> >> On Wed, Mar 19, 2025 at 12:15:11AM +0000, Joe Damato wrote:
> >>> One way to fix this is to add zerocopy notifications to sendfile similar
> >>> to how MSG_ZEROCOPY works with sendmsg. This is possible thanks to the
> >>> extensive work done by Pavel [1].
> >>
> >> What is a "zerocopy notification" 
> > 
> > See the docs on MSG_ZEROCOPY [1], but in short when a user app calls
> > sendmsg and passes MSG_ZEROCOPY a completion notification is added
> > to the error queue. The user app can poll for these to find out when
> > the TX has completed and the buffer it passed to the kernel can be
> > overwritten.
> > 
> > My series provides the same functionality via splice and sendfile2.
> > 
> > [1]: https://www.kernel.org/doc/html/v6.13/networking/msg_zerocopy.html
> > 
> >> and why aren't you simply plugging this into io_uring and generate
> >> a CQE so that it works like all other asynchronous operations?
> > 
> > I linked to the iouring work that Pavel did in the cover letter.
> > Please take a look.
> > 
> > That work refactored the internals of how zerocopy completion
> > notifications are wired up, allowing other pieces of code to use the
> > same infrastructure and extend it, if needed.
> > 
> > My series is using the same internals that iouring (and others) use
> > to generate zerocopy completion notifications. Unlike iouring,
> > though, I don't need a fully customized implementation with a new
> > user API for harvesting completion events; I can use the existing
> > mechanism already in the kernel that user apps already use for
> > sendmsg (the error queue, as explained above and in the
> > MSG_ZEROCOPY documentation).
> 
> The error queue is arguably a work-around for _not_ having a delivery
> mechanism that works with a sync syscall in the first place. The main
> question here imho would be "why add a whole new syscall etc when
> there's already an existing way to do accomplish this, with
> free-to-reuse notifications". If the answer is "because splice", then it
> would seem saner to plumb up those bits only. Would be much simpler
> too...

OK, I reworked the patches to drop all the sendfile2 stuff so no new
system call is added. Only a flag for splice, SPLICE_F_ZC.

It feels weird to add this to the splice path but not the path that
sendfile takes through splice.

I understand and agree with you: if we are adding a new system
call, like sendfile2, it should probably be done as you've
described in your other messages.

What about an alternative?

Would you be open to the idea that sendfile could be extended to
generate error queue completions if the network socket has
SO_ZEROCOPY set?

If so, that would solve the original problem without introducing a
new system call and still leaves the door open for a more efficient
sendfile2 based on iouring internals later.

What do you think?

