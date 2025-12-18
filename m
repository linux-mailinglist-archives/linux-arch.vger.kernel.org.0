Return-Path: <linux-arch+bounces-15502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB15CCDBF3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80B8E301FA70
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 22:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D42D94A1;
	Thu, 18 Dec 2025 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBSFaUOd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B929D280
	for <linux-arch@vger.kernel.org>; Thu, 18 Dec 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766095367; cv=none; b=s/b7ej+jhobZDihPJqYG8kvhieU8gvIEQun8sHXUeFy4S287j4R8W28voUM9WpYEEXvuaqaM1oLBeaZqb3tfHLd3X4zyT5z2iXN4HE5Gc/82xUKaNJAYT0hTcDBaRemQ0UQv9dcdlrBlrp7Q+agYNDCoICNd9Cwq/bjaVkrz7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766095367; c=relaxed/simple;
	bh=Bf2KYbMziPki3rnasos5YRzsDzuBX5KJfPRFOQinxlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL+KScPnij7UoLPCJ5sdRqol5qdQBNhJVu5FnrhWzb48icVPNxRBPEAC/zA2wp+ih2ZyKycuCEV3u2Yr1u9SmeUCsWg1JoyjQcTzvWEyWHRdZkw9oN4HHrcr5gEwokGkhi2PixpOY+3zxwR5zv4p2M6rrafdkVa5Gaptp/dYn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBSFaUOd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79d0a0537bso149330066b.2
        for <linux-arch@vger.kernel.org>; Thu, 18 Dec 2025 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766095364; x=1766700164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3VZdRP8NwaypFlr46kQWQp+Zi4z6sAOUbRUp8gjWS4=;
        b=LBSFaUOd/uTSPlc1g73TwydENpjtWvY6ukORzKZkklho+cNODOo1QXOjQZ6CckFzv5
         VN9+6EI5pCufWDS2TogyBccAQtPgFttIIpfJbhBxGRdx0usDecxTYeC4OqMFcQBmxuz8
         LiRiTA0hHR6n4j02SCgV6mcW16i/rXnkU8oMzFaUYj9pI4beIL6U5XuX0LFm2zVHM4O+
         QNmI9wLvIALz6qgr2OZ8S/0znilMgHmLNCUDwsk5Pr6ySTTSnHn60dqrpcNOOW3yj0mQ
         Vf4CqXg3lSJliueriAXL1YSWCnjVH8WGzkfreOqH5cXgYec9LFA0BTpCUgv5e6r1zpPC
         hdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766095364; x=1766700164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3VZdRP8NwaypFlr46kQWQp+Zi4z6sAOUbRUp8gjWS4=;
        b=EIDVD+8JOR4rN7ENcman4xYZnS4RY8ftnD/T1nGX2H+TXmd9ZIhenMU/QAXFxaD0xH
         DR+cya/90m7fKpsp2dY+96ylt/NTGUhWEQs22184oY4U1Kez6ls1urxht+KpXHjOrn4P
         CJNkx+xxI0E2b+JYJjLfgtJGvTp16QSmj+xf9xCV+ISsuXtP7sGoGELWV/LJaRdaLZzn
         g9ELfqTe6IyHd+vVA+4gBI0ZQup1UECulMonA6k+JEn128K1+nFVWNSvPqaFKhnsE+rf
         MNFBBpPw1waGJsLHpBcTlHBC//5Cnv2QhSkx0ITiDlXTpDWGT55vhdL+2KsK+v5N9Zvw
         a7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrPGpNH9zwFTff+lNPH26QT0s6A0yQlFbyen2O5I1eXRPzMaOxwkpfKAPJtmJTKx/0IgmcaGfDkq65@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jtXrI3rzUIahCDlJYbb9yMS9+3LtZKBOcM/6tuQIW+XMcjyD
	PT+z6nEj/E+h6m7VYm6I4DbQNLkovXYhElqGLBRzWxp3bJoRQDWBv3il
X-Gm-Gg: AY/fxX5CFqHpyaLjbydPrNMzBaHhScAANTcMyH9JuzY1de7V2piOgR3kMoK3WwQJXD+
	sAshDrCeE4wLKJR0D/G2al92tkqNReIjvjt+sO9Owg8tsn0swlF5N1HHpyBxfhBT4Drrr/SS2nr
	XqZVlWe5o3aZSG6c4jzewcTH1y7ybfso3focVAHNEjfyjfxkz8BHg+lMivyWIv8s0450VJTw0bq
	xvy3ejhOqpmWcvdg0cRaPVwlYHRoOWFH5UYEHc282fJiQgLeJzxHCI0zIzMuc3MZ4/lFCv4WH1A
	T9APow23s1/GU8zGMw5Dw6D1kKSeJB3jRifBQIFGxGu5NhyzJf1KTWWUy9eBePATBU9/utMUf8+
	vAGcBGa3VGFJb495iJ0IZjxU5XKld5VbfG4iuY3HlqgNOHofRlQ5RnBMd81WyYNmfhAawfwwwCd
	HfUw4IdOU=
X-Google-Smtp-Source: AGHT+IGC8nWpel+ncFSY/d62pIo9n55fFYIVH8WgqZxu82es9cY5UqEa9vD9DhmktlmW69ZmfTB99A==
X-Received: by 2002:a17:907:3d42:b0:b73:a0b9:181a with SMTP id a640c23a62f3a-b80371df391mr84490166b.54.1766095363819;
        Thu, 18 Dec 2025 14:02:43 -0800 (PST)
Received: from andrea ([31.189.127.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b7bcsm50069666b.49.2025.12.18.14.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 14:02:43 -0800 (PST)
Date: Thu, 18 Dec 2025 23:02:38 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Thomas Haas <t.haas@tu-bs.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <aUR5_kSv6gR_sITO@andrea>
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <0f7f3317-7a96-44f2-a3e7-a49f75bcd6aa@tu-bs.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7f3317-7a96-44f2-a3e7-a49f75bcd6aa@tu-bs.de>

> ARM has recently fixed the issue on their side by strengthening the memory
> model (see https://github.com/herd/herdtools7/commit/2b7921a44a61766e23a1234767d28af696b436a0)
> 
> With the updated ARM-MSA model, Dartagnan does no longer find violations in
> qspinlock. No patches needed :)

Thanks for the heads-up, Thomas.

This reminds me:  After your post, I wrote some script/files to test MSA
against the LKMM by leveraging the MSA support for AArch64 available in
herd7 and requiring no changes to herd7 internals.  I've put these files
in the repository:

  https://github.com/andrea-parri/lkmm-msa.git

in case someone here feels particularly bored during the Christmas holi-
days and desire to have a look!  ;-)

I am hoping to be able to resume this study (and to write a proper README)
soonish - but the starting point was to "lift" ARMv8 execution graphs to
(corresponding) LKMM graphs, cf. the file cats/lkmm-from-armv8.cat; then
the usual "test, model and iterate" process, with unmarked accesses still
needing several iterations I'm afraid.  Any feedback's welcome.

  Andrea

