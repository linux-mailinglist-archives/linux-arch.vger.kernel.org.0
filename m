Return-Path: <linux-arch+bounces-4955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF090C274
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 05:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2D51C2198E
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2024 03:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040DA19CCFD;
	Tue, 18 Jun 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkVDyqOI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542619CCFA;
	Tue, 18 Jun 2024 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681273; cv=none; b=Ny4Om9pvcT2jNOtbr5JbnMWG9rBA5lPCM5y+zeY3RmU49pihfeshTIGuD91/ybcHEurTRs/WvCxprIqKjE6rXJLFSo27nR/kXYCrw5Wa/6QtbixWeJgw+zvG2b/slSNY69ocot9uT36y0BpSdpazLZIPgV8u5ZTZEGn5PSNsCyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681273; c=relaxed/simple;
	bh=HbefAp3vXxAOCeTv2vKoJBxIINlbit2uQQySya1MK24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1bufQUxwU5HDYb7vppHqwLB1MjwHD1adOAGUivlyyR9nJKmroqgY/7jeK3kzUNIXNiTocuO/ltdDYOXgz3IMEkwdORExXBsv/Tg5BWa230brBjC13M95tUJrJBWDkeTFdcF6mS3hCvYv2gJOsy1FJEJSnSERtafhUVoqjGXmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkVDyqOI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57c68682d1aso5714679a12.3;
        Mon, 17 Jun 2024 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718681271; x=1719286071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWxdAnfhvd3kibdXJZ7Dn08Nbk7gxyBpm6SGjbYsWHQ=;
        b=hkVDyqOI/Gpgl63Ugcj7h8reKHV39biRoPPkDC+dJb7Xp8vfLT+XV7vXoovnfXHYN5
         vsfIB9EYgP37OciVMLfhzqru93ddAYm0c3/lQ8SMSHnxRCU0CFP6j+qPZQs2oxfL2vsR
         TCWdr73sc8TFXjnzQ39weKrwKGZ9zEl3mLXFCQSwsXXmmaAonZFHB0KkzYrcO5EdUNgo
         zGpI692fdixSAy3kLG4U8L0nzm7EQIU1ogKUdYBCGqmQ4TIiQGUa3OpzXnMR47N78bYj
         caagoHIaseSDP1fBL50Stoq36MxOmcR3f/bvc3LlDFLEsnrz3Xc9SAr5KVcEUnH1Hh4f
         lWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718681271; x=1719286071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWxdAnfhvd3kibdXJZ7Dn08Nbk7gxyBpm6SGjbYsWHQ=;
        b=QcnbTiC+GVVgaGEaiWaLq3GU6LDisD2hUmfC7pCxePugu0K/619B2XrliMOc9KDHXf
         DDUzbllKQx5WnGb4iabq7pkNBPYu/h0GImc9zrmhFW7D4271/ps+oamZWMSnwKinYle8
         tBEWQKRjPixV52WbmlcSIepw+VMPQ5l4UpyPiipzHJSlNy1tdUp4iyh0gGvKg5I5nolC
         vPvr69eIiTMLi81aKqHRPfAEZhues4h5iC84ezLU7s3yT8jm5OlUl6tXy4BOTvSo0fHA
         wrJoPIIBhDcNucVlJUmTA9GQZ/h+mTdrBZWHqVSEBZ/amYIFHrmpun6s2ZVcZM/4nkTs
         46MA==
X-Forwarded-Encrypted: i=1; AJvYcCWLFNrhUoDnvSUbZg9BV9JSC1v3q7AGDWHMTRAKERb2AuPkiQRqvd5Ai1t8dIF4YGIXIhNjmzDgZ/9mUp4s5MqZzVci9TKp8+G2vxdkLQzkKiX+MT2RcXrwAJxjmgoK4CvCdb8MRosjFQ==
X-Gm-Message-State: AOJu0Yw9PnL/BG231w9LShSc/sB8cO7Qrrng5f9mJVVywV+4T9r03DCD
	hTjNPhjnEsgxZDrgDQSHpF+O1j9rUNMnzdKwKtqpWMarqToWqRjb
X-Google-Smtp-Source: AGHT+IFaNlcI1hsrh3x8lmqvTKbksviHD0Ek24YPAuPEQiI19lcy+V4yn4D77PQ+9eNkOLdPHU6myQ==
X-Received: by 2002:a17:906:bf44:b0:a6f:63c7:3083 with SMTP id a640c23a62f3a-a6f63c73259mr780735266b.13.1718681270289;
        Mon, 17 Jun 2024 20:27:50 -0700 (PDT)
Received: from andrea (host-79-51-73-205.retail.telecomitalia.it. [79.51.73.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ecdccdsm571603666b.127.2024.06.17.20.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 20:27:49 -0700 (PDT)
Date: Tue, 18 Jun 2024 05:27:45 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, paulmck@kernel.org, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH v3] tools/memory-model: Document herd7 (abstract)
 representation
Message-ID: <ZnD+sRgr9C6r8+v0@andrea>
References: <20240617201759.1670994-1-parri.andrea@gmail.com>
 <ZnC-cqQOEU2fd9tO@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnC-cqQOEU2fd9tO@boqun-archlinux>

> Just to double check, there is also a ->po relation between R*[once] and
> W*[once], right?

That's right.  rmw = rmw & po

I could add a note about that, but I would stick with the current patch
/version (and your Reviewed-by:) unless other requests.

  Andrea

