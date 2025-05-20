Return-Path: <linux-arch+bounces-12043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B82ABE7FD
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 01:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805F47A6A1F
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 23:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC225C711;
	Tue, 20 May 2025 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSYXy7X7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9BB213E76;
	Tue, 20 May 2025 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747783338; cv=none; b=UV07SiWqNLtf/vSxrhHbZmIYN5FW+xYvGFnRNQnt90fmf9ptdvMXc7wJ0uxrQnduiSnPgWbnNiTV8NDaCztjgmEnbaLYcKkNAWXhuoqWObGfzxB/ouaN3imYWeq7RrfE04EfnPxF7eVhOJABb4/xutjGl6SJgmBjdiRW7pwTZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747783338; c=relaxed/simple;
	bh=7maajslVzIhtsJXiJNnD3bvbpPDqIuYaktb+YlP7h38=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0L5TOVMAqHqxXdBZDsW6K4TsRk15mOOKD2e5XzcuZ+VF5Ar3xP2p/WQopFh3ckCRpBxAdtz34o2fL0qs9FfWoIn/8HKWnmCZy/aCsuMAzxIvNp3bFrfQPY9y8y2SoqafdwU4I3+321glmqD1zP3OxxPoeALBaetLp1zXybyL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSYXy7X7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23229fdaff4so36590295ad.1;
        Tue, 20 May 2025 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747783337; x=1748388137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i63kZV37MfSfj+iuu6/NjHxLHzbbASiuRjp6q8dtjWk=;
        b=lSYXy7X7mjKC85tOThh2XbNkGJxt+4ZhuMJg1yQrdPGrAmL6usoj+U8fsLPxnKaSIW
         CIWhrZ/WeAV9+//wX7iVlDeDU4gx19+Mozm9136MzmdQg32clW9+Ly+eqhgGs63rF375
         U+q0LSVzhV9jlBGUwbxq25dIVsk/dazOuBj3+7RHwTL1EMPDceo+p7GsR0UoKcXBYIiR
         jNAiMmOX/yTBOEB6xX6Jk+ra3NsTnHX5xHlrCP8AtIKdEfAoNOrKN5sCEqWajfmPwLq/
         639cvTzMFbYbW46e4lhI0i+Ruwc5thpDH0VEVRged5PK4xqs1OZgNlkbKRb8Y+Wgz9d0
         0AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747783337; x=1748388137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i63kZV37MfSfj+iuu6/NjHxLHzbbASiuRjp6q8dtjWk=;
        b=fna69jaCYTy7TtY/sxRqdk2nSAW4w6Qj8c1FGU8FK35oUsJGezEadoFUaHuPjIo/02
         lAUCHCs4fmq9EEfAInu2xAMXyS8e4sbuBrPWMd+H3XoZIGWBSHShVrxulXVoVwqKvzBS
         2CVxxynN++dpDBLNOSyXVPLKUIyOakf6aPxCy6kpv3sle9XRz8yRu4Ny8DjuiTSG+TSD
         karV1vj3gPyIFUmm6K9k2A0vd3hdEDcNXconcLVdYSxNoELcUDGzJ9J5NWHpSV/V4gQ2
         DAYafdTMT8aa2c6kZ4Yjtfy/F19Hww34QyUB/1bfWL2UbWYzG1N0PaHINka3fS+etqvv
         rS4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0NJM23o5nJEymChBOr2KebwxThBZSsEJemjRaGLLD5bwvX8d6T5XtEOJY2pkPmEjLK3DsCQC0DCGSQg==@vger.kernel.org, AJvYcCU0nQh9rBczQtg9vCYu7jT9vQlxcVIlsum+Lu1BUnrBwVPJzTVEiWaEtkKh/NeeBMDOV4VTvqhkpfGMCvwv@vger.kernel.org, AJvYcCUpWqwV659ndtgAndvBZ7B/R2rZyGskGjgIg/3u7vTgS6MGLI0GUPklRVTPKTACIjKKOyg=@vger.kernel.org, AJvYcCUu4ZKM1K8PGTqddJezvl7gtcXwxUoeYvR02TRbYJGEpMHnHNVqtKOwUjFFLt9yZS3PtKLwHstr84KbX9QecA5e@vger.kernel.org
X-Gm-Message-State: AOJu0YyNEWdgns8qfZvWadi4JDfjeD4GFFrjO/FopCgGrkRvQSNelueR
	/MoPeXX6qZv/tsLcPB3FdEuadkP1jLHDjQSJcebfw3oaVdAnHtR0j+g44hGwVQ==
X-Gm-Gg: ASbGnctiHweqDfH8Rt0BDLIBBIr0wsAOski93IEE7bqRfRdOiK2Ywp60OPsHP9uaRkz
	FkWd/510w4m0MiSs0JdLL/9XskKoS/7a8PITW5FyO5EEwA8XWN5ydNtAax5ZGF/RBBydT0k14sd
	K1rusxgj/bl4tRLmscWIi4rxNDz+jKP9AFEWyJxJxDHLfWw2RKX6hIf0v+nP/X+sqPGbRlWKLmv
	KhzrY3W4Vczd9vAl1SL3qfmosajyldhmG3fCrMu3n1vfZIHXSxNGxQKxymaVfMszlGiytqrqd/w
	6DgkwBY5vBtJUPVd39g2Hnv+ZruoeVRU2Gv13zEK/xypRKtj5gnDKMJV4zifoSc1BGbnkk+AcZT
	NbiyoIJ7uVSiRt20RKsE9AkGw5x3u
X-Google-Smtp-Source: AGHT+IEAMmnmmWl5L3XrHgeMo1LwazGWWPRjpUMOwXPFuOdIrXOREuGJ3qKP54UthAtCdfdS+c+GRw==
X-Received: by 2002:a17:903:2342:b0:22e:3f1e:b8c8 with SMTP id d9443c01a7336-231d43a57e1mr277146735ad.15.1747783336719;
        Tue, 20 May 2025 16:22:16 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adb73esm81804185ad.59.2025.05.20.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 16:22:16 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 20 May 2025 16:22:12 -0700
To: Alan Maguire <alan.maguire@oracle.com>
Cc: lmb@isovalent.com, andrii@kernel.org, arnd@arndb.de, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
	kpsingh@kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev, mykolal@fb.com, sdf@fomichev.me,
	shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v4 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Message-ID: <aC0OpCZCEziDXhwh@kodidev-ubuntu>
References: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
 <fb6121db-9872-4e33-bc7b-82b026b0097a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb6121db-9872-4e33-bc7b-82b026b0097a@oracle.com>

On Thu, May 15, 2025 at 08:51:45AM +0100, Alan Maguire wrote:
> > I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
> > With some upcoming changes the library is sitting at 5MiB for a parse.
> > Most of that memory is simply copying the BTF blob into user space.
> > By allowing vmlinux BTF to be mmapped read-only into user space I can
> > cut memory usage by about 75%.
> > 
> > Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> 
> For the series,
> 
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> 
> Tested with 4k and 64k page size on aarch64; all worked perfectly. Thanks!

Hi Alan,

Thanks for taking a look at this. I've been following your related effort
to allow /sys/kernel/btf/vmlinux as a module in support of small systems
with kernel-size constraints, and wondered how this series might affect
that work? Such support would be well-received in the embedded space when
it happens, so am keen to understand.

Thanks,
Tony

