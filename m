Return-Path: <linux-arch+bounces-8107-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5136099D7E6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 22:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0923B212FE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A311CF7B4;
	Mon, 14 Oct 2024 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ag9bTncm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C80E1CF5EE
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936559; cv=none; b=dnIM33PqSikiE0Sy4RgMwrYyQXCPRfd9yBIlc8UBeR3TfAVMjUT/1aMyG9xyxxnRuJN3SJQygloHJLACIOjx8+1saHM+qt8xcUgM2wsiv2MgR0vGrIfpBm7mUJbYKdg3cLK5vPCTPirK90QTFFCB4dbQvrkdJ2ngLe7iom0rtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936559; c=relaxed/simple;
	bh=pNaDbRzoZ/ch2sXe8zWNqwjvHPWMDpOqULepUTLUdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s69IpYUK3vN0Kp+SYo/htmvlEbAUNunTy6N715r8+bzG6jqMUgAX3fAeUnJJlYSVtIjqPgVRvgh+HS+VCogxIMsTQ1BeDEbUBr8wcEb4X3natz1+6QrpinNeSqXjSPuueg1Tc71V9j3d/XbMp6/P7unGKcq7V6UcEhiaJ1dPQ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ag9bTncm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so28253a12.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728936555; x=1729541355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0zqaAbHeI1jkohxhnn3/eoqtBWz6fWnFImTtGcQALM=;
        b=ag9bTncm5vPI/p17T9CR/FjmPdlcay/2/rb3nfUlYq/36+rNK2PIlUvno5LwH03mNH
         E9FJZG/XRh30d9CUWj6DZahwOFcGvNrQMOEkDJNhjMab9LHrliLOd3FRXY/2JqKAl8+V
         vvaRfyXtUALsqKCmANzBdB76veE7mxEVJxNoYQ/aAoDmBzDXyLE5FpX1FjlJYL1pA1Co
         0VqAPiAIZ9DuNoc1VjSpoNUthXSp0wtJK/stVXucRg0h1Ha5OcRpnT28eJo3fgJLO6c9
         8+ntktLZdY3/CwzTs2S3B3Cx1Er8JlO05v3D38ct7sl6waYQFd0wu7jc0Ax13RTNAEHM
         zyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936555; x=1729541355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0zqaAbHeI1jkohxhnn3/eoqtBWz6fWnFImTtGcQALM=;
        b=lGfwLE+FHsKXRMkUZV8kNy3asfKE0i8U7n3Mdi0rZ7qJ5ivkrY7os1q5ryWxlpxEK+
         3u89goSXRUVHzFuObJy3bWKlogiNUzuSVGL2uivp/pYqDPDTNQSH+Am+oty+QkonVtOJ
         yOasPnxAwioK3D71yx3/j/ZqEBqdGPwfpge2cmI9k2QhxM5GMnZtSnDwF0oRdwke8kru
         T8Ta+1DK7e6QApvUpAh4OEFmu5eTzocuo+hTLaahdsWO37IsrYJLXohy36lPSxCfuIXA
         w/B6hnHErurEjaKrp2OFrZ/EEkdNWq5U4A54dscbc51KqqclD5NYzrm9B3FT1C33rOph
         ZLxA==
X-Forwarded-Encrypted: i=1; AJvYcCWOeUHcLEMqa7tYl09RhUgJVEKZ4ADuoUXmlL9KVKhudM3SzNB0S+oeKxXNSu2shwns4ZDPAUkWMBL7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87NkGCaqS3sXC9BiIJPh+qQw6ird13K8muXTCw8RytAGaGdgg
	bSBQRiYltiQivWOAKKeJYlCBRaeAG222rgyY3KdkHZG1aQnQ63jyVkiNQSSEU7mfXBNXdwkCG24
	oawbmnAher19IsnRKSG4vXiUfDOEtFU0QyKnS
X-Google-Smtp-Source: AGHT+IFe+18jaYfQr+21B0WFTGQIwcQex+WsgK+bAeIFw8v1CVPL3tiWr1CxsaBhl5XE5hKvMkCXjZhdZbiCyhqn9EA=
X-Received: by 2002:a05:6402:3495:b0:5c4:2e9f:4cfc with SMTP id
 4fb4d7f45d1cf-5c95b38b9a3mr532129a12.6.1728936554221; Mon, 14 Oct 2024
 13:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903232241.43995-1-anthony.yznaga@oracle.com> <20240903232241.43995-6-anthony.yznaga@oracle.com>
In-Reply-To: <20240903232241.43995-6-anthony.yznaga@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Oct 2024 22:08:38 +0200
Message-ID: <CAG48ez0OOpw17d73wB_HC55FVLeKOz0D9+teEHe7YAsY_00=kw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/10] mm/mshare: Add ioctl support
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com, 
	viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org, 
	andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org, 
	brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com, 
	catalin.marinas@arm.com, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org, 
	rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com, 
	pcc@google.com, neilb@suse.de, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:22=E2=80=AFAM Anthony Yznaga <anthony.yznaga@oracl=
e.com> wrote:
> Reserve a range of ioctls for msharefs and add the first two ioctls
> to get and set the start address and size of an mshare region.
[...]
> +static long
> +msharefs_set_size(struct mm_struct *mm, struct mshare_data *m_data,
> +                       struct mshare_info *minfo)
> +{
> +       unsigned long end =3D minfo->start + minfo->size;
> +
> +       /*
> +        * Validate alignment for start address, and size
> +        */
> +       if ((minfo->start | end) & (PGDIR_SIZE - 1)) {
> +               spin_unlock(&m_data->m_lock);
> +               return -EINVAL;
> +       }
> +
> +       mm->mmap_base =3D minfo->start;
> +       mm->task_size =3D minfo->size;
> +       if (!mm->task_size)
> +               mm->task_size--;
> +
> +       m_data->minfo.start =3D mm->mmap_base;
> +       m_data->minfo.size =3D mm->task_size;
> +       spin_unlock(&m_data->m_lock);
> +
> +       return 0;
> +}
> +
> +static long
> +msharefs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +       struct mshare_data *m_data =3D filp->private_data;
> +       struct mm_struct *mm =3D m_data->mm;
> +       struct mshare_info minfo;
> +
> +       switch (cmd) {
> +       case MSHAREFS_GET_SIZE:
> +               spin_lock(&m_data->m_lock);
> +               minfo =3D m_data->minfo;
> +               spin_unlock(&m_data->m_lock);
> +
> +               if (copy_to_user((void __user *)arg, &minfo, sizeof(minfo=
)))
> +                       return -EFAULT;
> +
> +               return 0;
> +
> +       case MSHAREFS_SET_SIZE:
> +               if (copy_from_user(&minfo, (struct mshare_info __user *)a=
rg,
> +                       sizeof(minfo)))
> +                       return -EFAULT;
> +
> +               /*
> +                * If this mshare region has been set up once already, ba=
il out
> +                */
> +               spin_lock(&m_data->m_lock);
> +               if (m_data->minfo.start !=3D 0) {

Is there actually anything that prevents msharefs_set_size() from
setting up m_data with ->minfo.start=3D=3D0, so that a second
MSHAREFS_SET_SIZE invocation will succeed? It would probably be more
reliable to have a separate flag for "has this thing been set up yet".


> +                       spin_unlock(&m_data->m_lock);
> +                       return -EINVAL;
> +               }
> +
> +               return msharefs_set_size(mm, m_data, &minfo);
> +
> +       default:
> +               return -ENOTTY;
> +       }
> +}

