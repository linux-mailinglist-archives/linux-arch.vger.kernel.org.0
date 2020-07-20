Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C42255F6
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jul 2020 04:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGTCtI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 19 Jul 2020 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTCtI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Jul 2020 22:49:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9278C0619D2;
        Sun, 19 Jul 2020 19:49:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so3798280pjd.3;
        Sun, 19 Jul 2020 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=MHAQuV7wqFXE2gTJXyIGBJkkSS+/2fb6/SqEN+IMJpU=;
        b=CdpDdzgwHD6KDQNhDlu82DlmyWWjZ/tE6sKRBv4R+f6DNQQk3obKV028wEN8NHQe44
         ivpvsS3MyhDPBNTyPoxFeJ7XFObRFd8p5lDUvQWmEZLORZNpDUmsYDtCQtQBjWEph5Jh
         4UbuZHebtzX2AFmWHCKMSDCUU6CrNCv//mNYHHIp2g9SX31oJe5mi7j4eUwDehYc29+H
         ylq58SwOBe5p0fVnwPLea9PkWcZG7C43Si1MqGYbndJH1usUs612RiFtiYzoCGbhlNlq
         NNAAB8WinXGMNgzrYPheT/QyRtpMt8ZSuDngMgeue+/ZpaK+oENAp4e9Kc8cNPqxAKW8
         HoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=MHAQuV7wqFXE2gTJXyIGBJkkSS+/2fb6/SqEN+IMJpU=;
        b=jFmBMDJsu7xDxNdkT6oZZ4lJFvv2MyRccAyI6174/3LjpebageeX7YSJXTr3jnoGIG
         1v+P3CXXVZJW0u2HjA/8SIIUzBar8iOArMEf1soMYvS8hI49Q64c8aAoomwo6p4ufb2E
         KZnMxLrznSUMWUuW/RT6UiCx+bi1WzuR/lBB7se92gxUS5b+pGGihbde0Xkh3PyJxYU/
         oI3JKNATK96RFB5KgbvF9owud301hXsuU1aaabfVCldAZc3bnKK14Fkg9q5qaGJAWjqU
         VSfHgD5qmz2HKeNmH51ejdzi772qHEvcVSlAoIStyg4exBiAijGk59/daNkNB4F+XiXs
         uEBA==
X-Gm-Message-State: AOAM531TT++3IdnUnmBVbFEvETFqUBSe11FQuUkB3r6OQmOUz7IEOrFn
        KG3dpqftTYfNUHwX/bHTEbk=
X-Google-Smtp-Source: ABdhPJyKOJqndxCg3mIhcaYDZPJSsTmVuKMyFWNLPeExLhzmb2sdnZbuRmCL/dLOi+bJNfrzWai0hA==
X-Received: by 2002:a17:90a:6448:: with SMTP id y8mr21541193pjm.142.1595213347563;
        Sun, 19 Jul 2020 19:49:07 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id f131sm13389215pgc.14.2020.07.19.19.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 19:49:06 -0700 (PDT)
Date:   Mon, 20 Jul 2020 12:49:02 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     linux-mm@kvack.org, Zefan Li <lizefan@huawei.com>
Cc:     =?iso-8859-1?q?Borislav=0A?= Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?q?Thomas=0A?= Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <0e43e743-7c78-fb86-6c36-f42e6184d32c@huawei.com>
In-Reply-To: <0e43e743-7c78-fb86-6c36-f42e6184d32c@huawei.com>
MIME-Version: 1.0
Message-Id: <1595213278.m30kayfsvu.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Zefan Li's message of July 20, 2020 12:02 pm:
>> +static int vmap_pages_range_noflush(unsigned long start, unsigned long =
end,
>> +				    pgprot_t prot, struct page **pages,
>> +				    unsigned int page_shift)
>> +{
>> +	if (page_shift =3D=3D PAGE_SIZE) {
>=20
> Is this a typo of PAGE_SHIFT?

Oh good catch, yeah that'll always be going via the one-at-a-time route=20
and slow down the small page vmaps. Will fix.

Thanks,
Nick

>=20
>> +		return vmap_small_pages_range_noflush(start, end, prot, pages);
>> +	} else {
>> +		unsigned long addr =3D start;
>> +		unsigned int i, nr =3D (end - start) >> page_shift;
>> +
>> +		for (i =3D 0; i < nr; i++) {
>> +			int err;
>> +
>> +			err =3D vmap_range_noflush(addr,
>> +					addr + (1UL << page_shift),
>> +					__pa(page_address(pages[i])), prot,
>> +					page_shift);
>> +			if (err)
>> +				return err;
>> +
>> +			addr +=3D 1UL << page_shift;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +}
>> +
>=20
