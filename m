Return-Path: <linux-arch+bounces-5945-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE5946297
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3231C23773
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00D1AE044;
	Fri,  2 Aug 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKykl2oU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE261AE02B;
	Fri,  2 Aug 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620066; cv=none; b=hGpdXBFl8HqhOPh8iCLy2j6miwpLSKmg0fkMv+jgizqt+v1MLm2pRU41rGyoH/9Zf4hs9M2xZbzcr5urPnvKk8srEhMmeGL9MRvfDxH4z1FAevbEpEPqUQbfcQz/FC6I9oXI8VM+b4ixtO3be3fTi0RdbK0fkqaUK1rWf6KsPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620066; c=relaxed/simple;
	bh=H46XU4flydlMAniLAo+k795WzPyLoyVvy7vAZx7j73A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/+ZZXtOceFUB/jR0/CT8IV+dCqUY5D7DJ2P3KigY62L6cfg457AfqS/P/kmZpokw3x9n09MkUTm9RsOZZYaYYaqKlkJXhv1tjJFQgpidn/tmJzRd2zKd6BxfK6kqISF8NrATG4meZnZ/a3DnySX+24yUnrDkROpB5Wy7bxk5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKykl2oU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fee6435a34so59987185ad.0;
        Fri, 02 Aug 2024 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722620065; x=1723224865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gatNmUJpvUibb5XpWXl4cN6fAfKNOEybzN60sP4r15I=;
        b=ZKykl2oUmzl4cjIkpmCudlgsWIFiCweDT2923qlnWJuanexb7sTNDg8vmkFnELkCa+
         Ybzm99u/lwc+G2NEC9J1f1kpnKzJU6gmtCP+BqUekHTxXE0TjUepnb9lQBarCD0lmFf9
         i/sr5abMOcBFEA95lsVhTa3U/btpU+AHrh3X4/0Qm7MLW8Iovsm3Towj4WihBRnQG53I
         TcPoqpXbN/b8vEGrdQdvP8y/iiJeQzvQEsYqCmVWP9PA19fLxYThDpCldnZS5/eRMiBs
         KqcfA/AduEXL9ig9O9KIHrKgDwSEesD5/Xw3zqcriFiDm1H7h2A3h6TrbN7y/sMOJdIE
         E/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722620065; x=1723224865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gatNmUJpvUibb5XpWXl4cN6fAfKNOEybzN60sP4r15I=;
        b=nDDqElNSvTBbS644MhAGLg9CwOhAtYGvXfirjpGEHY32xNkx6m9Lbz9WvtXW5DLX8s
         TfPi2aQ67lCRQ5tiEnVX0t81WPjConfadBTeVe36forYPFp+Ixih+wle+giqbtkawxNm
         O98iyqsWZ5DZJsLv4SQMzSY+sAVXaX9eH+Kyr0EfAhAhvm9QreVIVY7CKg+rTA+aeC9d
         Xayhf3gx9LetCfcL2xp9lmevSeBVb/XGwLi6c2RZ9swEYq8PsmnMhz8D43B45Mdga1j/
         D5PdFnwfCCeHvBfrnHkzTh6Dfa3le9c53reoldN2rCYKJ3/C3k8agKrupvbI13ai35nH
         xiYg==
X-Forwarded-Encrypted: i=1; AJvYcCUijGIE/+x7D0dKIH9Hdzg0S5VWkOWPUOa+HsPwjwf07yDv9+gb+UBfPof1pkInj9Lbl3xJNkqNkWneROLTKa+o9LydVCkrJE5lKA==
X-Gm-Message-State: AOJu0YweCHkCtFdeneKuMINtVWYRDMR8H6yxz7QJvVwdBt3NV4s2gNus
	mWY1OYKWUg1/Y13y2NhS9WbmaU3uFr46oi0DKyLGmg9cuSJFqJIF
X-Google-Smtp-Source: AGHT+IHpOyiWX+126Ucw7sJfURuG3QEh7Tmy3MxbOJnPRawX58YxC7bZQ1pMFDt8cxJbbaq7dFAdwA==
X-Received: by 2002:a17:903:2308:b0:1fd:9269:72f0 with SMTP id d9443c01a7336-1ff573d8baemr41975385ad.47.1722620064517;
        Fri, 02 Aug 2024 10:34:24 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592979d7sm19812375ad.259.2024.08.02.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 10:34:24 -0700 (PDT)
Date: Fri, 2 Aug 2024 10:34:21 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-kernel@vger.kernel.org, ardb@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: Re: [PATCH V3 0/2] uapi: Add support for GENMASK_U128()
Message-ID: <Zq0YnYAM9RoforVV@yury-ThinkPad>
References: <20240801071646.682731-1-anshuman.khandual@arm.com>
 <CAAH8bW9sJmwKd19sJzpGrQ5Tr_4fYMyvLnfFyahhxxkG6r6GbA@mail.gmail.com>
 <1781c39a-2280-49ed-aaaa-b1684744615e@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1781c39a-2280-49ed-aaaa-b1684744615e@arm.com>

On Fri, Aug 02, 2024 at 07:00:43AM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/1/24 20:13, Yury Norov wrote:
> > On Thu, Aug 1, 2024 at 12:16 AM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> This adds support for GENMASK_U128() and some corresponding tests as well.
> >> GENMASK_U128() generated 128 bit masks will be required later on the arm64
> >> platform for enabling FEAT_SYSREG128 and FEAT_D128 features.
> >>
> >> Because GENMAKS_U128() depends on __int128 data type being supported in the
> >> compiler, its usage needs to be protected with CONFIG_ARCH_SUPPORTS_INT128.
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Yury Norov <yury.norov@gmail.com>
> >> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> Cc: Arnd Bergmann <arnd@arndb.de>>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-arch@vger.kernel.org
> > 
> > For the patches:
> > 
> > Reviewed-by: Yury Norov <yury.norov@gmail.com>
> 
> Thanks Yury.
> 
> > 
> > This series doesn't include a real use-case for the new macros. Do you
> > have some?
> > I can take it via my branch, but I need at least one use-case to not
> > merge dead code.
> 
> I have recently posted the following patch for arm64 platform although
> most of the subsequent work is still in progress. But for now there
> are some corresponding tests for this new GENMASK_U128() ABI as well.
> Hence it will be really great to have these two patches merged first.
> Thank you.
> 
> https://lore.kernel.org/all/20240801054436.612024-1-anshuman.khandual@arm.com/

If you're going to merge the above patch in 6.12, you'd normally send
it together with GENMASK_U128 preparation series, get an ACK from me
and Rasmus for bitops part and move through arm64 tree.

Whatever, I've merged it in bitmap-for-next for testing. Please keep
me posted for any following patches.

Thanks,
Yury

