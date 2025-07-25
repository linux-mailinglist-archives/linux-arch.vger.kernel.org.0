Return-Path: <linux-arch+bounces-12951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B17CB11D25
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFE116EE5C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C692E4271;
	Fri, 25 Jul 2025 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFqFrKcQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD89217F33;
	Fri, 25 Jul 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441702; cv=none; b=A/EAqH166nOinZgdt7hIMFhitG1LRQOAqpR/t3ytK975q4CxjQqaE+6v+cRXcPDvgmOuGovarcDr48VEsy5p03fOUF6WDlxRE2jU7KFinLGrAa+4rrvvBO5wLV+moLGlOI7D6DDXXf+RE11TLO08hvODIhk3KNSbsXwxKG5TmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441702; c=relaxed/simple;
	bh=dLVIv41rWSo97X2xoetUsogBS0HyvRd6CcH34BoydPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAizVOvfk33vn8iZMyIHAz5/UOSQ05ezZGTCc2hJfVHkR2NJE8KehBONpdXRnRnt5mha3mZcR/r8Lbr3KfQM/60i/ztFBBc3yRKeClssOC3pKiTtaU0qF1/CK9HpuAbjJvnpAoIYDMpqOTnU/XphJlq4yAwvbCF3wDWcAoMOKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFqFrKcQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2350fc2591dso24170185ad.1;
        Fri, 25 Jul 2025 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753441701; x=1754046501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLVIv41rWSo97X2xoetUsogBS0HyvRd6CcH34BoydPw=;
        b=TFqFrKcQE+t7AXBbdo+xYzYZRBpAj/Yt2P6vWXCoIoRHGZtAbGq++3PS7bk3Y4iKJm
         7Alo7nKYwHrNcG8JA83Id1wn5gAEr5mdNVwhsDXZAEOXfWhGePeFsfZPYosNHnt3Azcx
         XYKgXZDm6bcOzupWi/QRIf/DGNTnStEiIGBbmSxzqMgHFxNd21+OwigTV8cD4OFedeeQ
         EiSc4Rc63sI+71BV6RwR+kNXXP/5biX9sDh0gTTRhHUvXwK6vd8jhgj3xkW2Dq9Y54ie
         aNbdhZFFXQyxRFMdfuSE6ofIxH6/9k61xvFyXrki2Pn6ffmovQ1EH7lwfGfuHrCmS3hI
         mOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441701; x=1754046501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLVIv41rWSo97X2xoetUsogBS0HyvRd6CcH34BoydPw=;
        b=ZbOOpflRldGV72XnTMQ+lVbNIxpaSKiurHTQtPG9GpSj375v741PWIZvrbhapqwW8e
         9dwWk2fGc1psThla2rivu9B+jiYRCe4uQJKGFIBS28fg0c9rxBcIMFxvKVPH+ZQcV84A
         TmQ1NMnb+HGFqvX7siJg5+Tg7o64ZViXdWeCULhRUMsg8U5hTZi+Rz+Xlf6TjKqlFvY4
         YLgiGi59USOcmUxVFmVDmKgwTLeYnFYDQmlxZgRmFYgH2rKDa1l5qyvvYYUAS4K1ajp/
         8At9QzI7/bcsKeoiPdkTwnCBtVzLccwjcynx5JB9+kPYxUnXolgEk+wEZZKUvTz/0q2Q
         +VJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCyEPRy3dB97As0ntwm5rhdg+eDkJX2SfRlexalb5YedpVBeC68Gmiodk3TU6CbQZZLX5xW3Pieu7gIB52@vger.kernel.org, AJvYcCWb3ODh1plUORXjnwHUKK2LmsM4C5oZGAaMMq/KBs47Br7OdbHRQr6jH414K4gNsmP4zMZVxYRRxbEb@vger.kernel.org, AJvYcCWjRqbyYEKH4GxmZTI4utC45/g1MCEGq5Q3TIEXng6BexpHYSp8cXy+x4E0bo+J4PNVPogjSTPBJdzrpF/j@vger.kernel.org, AJvYcCX13adP/vXiu+G5GhlCcjmJzxBbV3bdLo3UWYFZbyTM9agJAyc+lGa61vJ/+p6dZqNme0nEftk0iFgY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp/xDSOu8sKgAF9rpBDpWI4b//qwi3EVCt2MOecM13Yk3L8wPN
	h2cDSX5g6dn8BprGWzQSCEas6z7MdKRljUsCW0cUBZcxWcARPkZSVsMFMuT60BbuthGKOC9RoTe
	BLWX/BeHq0CqJn9xl179jInf/d4n9T18=
X-Gm-Gg: ASbGncuuu8tXZhsDGXKRP4ACjtMQjJspobLUKZUbp5iTvSaTHKhBEzErQfuew/Q2zTn
	mNSu4vhhRXvNnKS32EYxIp5KwybHVew9ic9+oqr5RHyva9iVaViqRJLBHxamQmKto8/19GV78Jr
	OL7g5ihXPyNJu2WWilYa5yREScOPp4plpaO5TVGa1JpXZSBwoK5Rf4Dnw47ukDr+j6HenpM6+Fe
	EkJ
X-Google-Smtp-Source: AGHT+IHfE0O//VX0wStE+T7I/MutBAXm3En5t6OVKcspLL/SoC/4kpBYMFjZMvwN49zLxcbne+cHozngWwP0Vh/P0xQ=
X-Received: by 2002:a17:902:ce82:b0:231:d0da:5e1f with SMTP id
 d9443c01a7336-23fb2bc6c70mr28718045ad.21.1753441700537; Fri, 25 Jul 2025
 04:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714221545.5615-1-romank@linux.microsoft.com> <20250714221545.5615-8-romank@linux.microsoft.com>
In-Reply-To: <20250714221545.5615-8-romank@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Fri, 25 Jul 2025 19:07:44 +0800
X-Gm-Features: Ac12FXzQu8VeJjXldh1azHy1zVkvNFhCSGqwqvAy7CtaMelN_ZcDpAZXus1a6Cc
Message-ID: <CAMvTesBriJcLdxyrBbGjj0Gh1aoE84uPbnZ2DMKnmPaTtRjWqg@mail.gmail.com>
Subject: Re: [PATCH hyperv-next v4 07/16] Drivers: hv: Post messages through
 the confidential VMBus if available
To: Roman Kisel <romank@linux.microsoft.com>
Cc: alok.a.tiwari@oracle.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, 
	hpa@zytor.com, kys@microsoft.com, mhklinux@outlook.com, mingo@redhat.com, 
	rdunlap@infradead.org, tglx@linutronix.de, Tianyu.Lan@microsoft.com, 
	wei.liu@kernel.org, linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com, 
	benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 6:16=E2=80=AFAM Roman Kisel <romank@linux.microsoft=
.com> wrote:
>
> When the confidential VMBus is available, the guest should post
> messages to the paravisor.
>
> Update hv_post_message() to post messages to the paravisor rather than
> through GHCB or TD calls.
>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---

Reviewed-by: Tianyu Lan <tiala@microsoft.com>
--=20
Thanks
Tianyu Lan

