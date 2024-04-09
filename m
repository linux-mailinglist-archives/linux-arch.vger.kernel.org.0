Return-Path: <linux-arch+bounces-3528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317A189E23F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A941B26299
	for <lists+linux-arch@lfdr.de>; Tue,  9 Apr 2024 18:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E02156975;
	Tue,  9 Apr 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FttKq7Yz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7434156870;
	Tue,  9 Apr 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686266; cv=none; b=Y6CxGQ0GUf2ehi0stcvZpABUFDO68EsyQ4ZZjGei7E0IAiTpzANV0cdpU1Sd60JMih0sBiPznkbh9NyQ7ILA0RtnAj7NO5rCk9MhOD8qNyINsmuYGPlRlZsWeAu4HTfzypV7xc/EAiZAGozoN3qf3CIWcjZ5tQm7Uoh6xcUVmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686266; c=relaxed/simple;
	bh=HqaMdhT5LRYjCxR6gMHB6EOhgxJSaOa8vauHB4zv+2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEcXLkEQW6JyFiEwmibcC3WtjFMfD79IkVnGtESa8JlYs4ay5DUpopaCaLfXmKFzko6SIUQtdxstnBUDafbxRBsJKoGPCrdA7Vk860hmUqt0Am/x1Qg+YQ4VBolz/2UF1AjyYYVKUKz3CWRCQ2HF0kScy+9Ca0RDkS80k4Y0/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FttKq7Yz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e220e40998so37525675ad.1;
        Tue, 09 Apr 2024 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712686264; x=1713291064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9dSAKFdynyhKujjaxO9n/FtMdq9OcS8F/T8JeifJ1k=;
        b=FttKq7YzQibSu3QkW5wm1cfur0Sb9eg8CtXs6WKUr9zGDaPWl6iuiLJeLdFeC/iNY4
         8LFySLpve+36Cug69jRdkAr49JZayGOQ+h79XwJLmN+RGRoU5XlOio1N1e8jd9GEJEmv
         JRMv+qzkoHFdB1b4Bxkp0G2VFJ3rVPH65aFOHo/NDDOX/PNkNDIVWpjBAvpVTOv7ykb3
         9ug8dXeQdHgfj6UX7ce9WAcNpBnhctkosX4i9G4T6hn4u3kGmYVz8wHyawwXjvaARlGr
         yFs6XU8whVQDxMNKSkr4yiUhYOMcVBmPngklvhlTodqo1z1xR4SxxVKF1dlxKqaRVvui
         668g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686264; x=1713291064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9dSAKFdynyhKujjaxO9n/FtMdq9OcS8F/T8JeifJ1k=;
        b=HP7vlWjUZAWHHrddjNVv3YgPx0I5azs3kmojBst3vtYYxrA1D71oIL1wOH19ZY4TUs
         ftaKyJOnrw+v9UBFB6a0bqBKbqbLpNs68NhxBc6I4UQlLhfvlyNm7sZzP5HRpPyyMRxw
         QVJ6GxsL0bzbuCMLLppGiH+IjkYaaBcj2IV9fcIdUXrq2ShDqTfQuupwK8tiTUbdR8OO
         OkNIo0AogoEn0JW5q0nLKvHf37jwnzqqiZbnxJXTcIE6YW9tbYBas7IdP4x23WyjvAjD
         FN0NrJuAkwufQY83aDqkWLEtN1t1r1vTmI+aONn9zP6XzWpktxVLO4uGULpNYulWc91k
         CGAA==
X-Forwarded-Encrypted: i=1; AJvYcCWOIUq17MX3ojkp1V6Cw9t8Qzn0i7G+B0PGVWhNdNF0DHrikTZ1ScpOCibZaWUiQp6wgT+fg9eMxG/BrIIsRv+ANw33tAjJ8YbWCmPgmBXNdd2CZ9lphiimSkE8vBeIC6loU/9Ymmbt0q30VcajpRlnS34lU1J3DxmLpI8px8Vrd/4WT97R1PLf03PTLkeZ8F32eeVIrP3AiQyVZfVGiTyuaal6tu0B5qARapkRPBBrrJpzrPwvQfwmsTJSMHcsEjkaej8h+uRDEB1Drihu5D3Nyx/memLkjrg5udbv9++s8OCrYu/nGgSZYMTdhiMc7Q==
X-Gm-Message-State: AOJu0YzL7OMOZU2B65EthKr0eCDvgim79p+ud0OvzG96sNBtdoh9Tnph
	832vI1K28ki+3abjxbs+JvC89QxEWnzd7y3ealZCI+MUo6NH3lPv
X-Google-Smtp-Source: AGHT+IGrjPVdFECKS3becNGGDDo38peM0R3uLnfzfKLi+hNrIYGQpqn6EkGBto25qlTyktqlNq6njg==
X-Received: by 2002:a17:902:82c8:b0:1e2:3e1e:3d9 with SMTP id u8-20020a17090282c800b001e23e1e03d9mr529751plz.63.1712686263974;
        Tue, 09 Apr 2024 11:11:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902f25200b001e256cb48f7sm9195770plc.197.2024.04.09.11.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:11:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 9 Apr 2024 11:11:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v3 03/15] kunit: Add test cases for backtrace warning
 suppression
Message-ID: <aad25d52-83ed-492f-9d56-71d26895173b@roeck-us.net>
References: <20240403131936.787234-1-linux@roeck-us.net>
 <20240403131936.787234-4-linux@roeck-us.net>
 <CABVgOSknXkT=WU-fwi5wP4bWv04DKByxSYAPmhYhC--FaQH-PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSknXkT=WU-fwi5wP4bWv04DKByxSYAPmhYhC--FaQH-PQ@mail.gmail.com>

On Tue, Apr 09, 2024 at 04:29:42PM +0800, David Gow wrote:
> > +ifeq ($(CCONFIG_KUNIT_SUPPRESS_BACKTRACE),y)
> 
> s/CCONFIG_/CONFIG_/ ?
> 
> 
Odd, I know I tested this (and it still works ;-).
The additional "C" must have slipped in at some point.
Thanks for noticing!

Guenter

