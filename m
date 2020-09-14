Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A304C26825A
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 03:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgINBta (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Sep 2020 21:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgINBt3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Sep 2020 21:49:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44621C06174A;
        Sun, 13 Sep 2020 18:49:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so8220967pgd.3;
        Sun, 13 Sep 2020 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=0YS1663L1LzUAznqusfmielYY5IT6EGMpzPyhkJQ7Pg=;
        b=aS3VNXRCtipQcZRfa7a6tudxDiYKqA3Gz4zlK0itlhG5MYkd7dKfMhgG66FijWEGr9
         3UlITHtVnMKV0DVKAbn6lIlDUqudRyx4IyO56SZIMUzWc2aBS1/BEmV2V+xiaj2cQR+O
         ukFK6q0B5Jy8GpBSiwxjCHtLienaCXw1ZM6QdSSeapYEqDGArJPsmGRm4paHAOwmwHUy
         WGXG/VdqDl8MttghiU9rPXRPkVc8zjklfrg6xPU53bhCj3ncH9dWLybh6zGby3JL5wvy
         QYYyB/Iuvsr9oYWqhSeIBYsvbDI6rJJAhy+Gn2i8V0fxU7hvQ1F0OPQLMSamcylcGJbz
         kfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=0YS1663L1LzUAznqusfmielYY5IT6EGMpzPyhkJQ7Pg=;
        b=HcGhsQXl7k++CRp5kQIZSs9DQeEcdNtWE28b2T9j3KtB01PHtU0eDrDtCPoezBcN88
         3OvzWdq6ZSDqIBKEbr7KL+SrMjbh40LmvraRxNUuLxmK5hkxbzKybVgzLxh1613UYOnM
         N5olGNrfxuHr3+BLqxe/nVJBCSHVC28vAuLPI5DfyBIYlIkxEMnRFQD9BWhbwpZpSEYF
         HQvrzEqNyaJ/+qdyYSdXx4kpn+PATWIDP++LCYoEIY4botDvOVQRgFcRf2VRYqScPmsR
         7rvkssoq3g4qzGqmfhW5TrA8lj3Taj/qBqmbQ12pMawqEHGZYQ3M/1ZlQOscqiSIPGCK
         Mb6g==
X-Gm-Message-State: AOAM5320w9NcFhPdMf4Ufr42pEujfgpSzPF5JSCOUQ61tJqICQBb5pnZ
        qmWdjxHEZrBcXHu12j3ZEEE=
X-Google-Smtp-Source: ABdhPJyubYTjN2Pj9IUYo2h8nl7y9PDk3yWqMleRixdLIZRvEKOz9/fk4Z+JpCcJeQBq5RQaO2aFhA==
X-Received: by 2002:a63:1016:: with SMTP id f22mr9291708pgl.226.1600048168254;
        Sun, 13 Sep 2020 18:49:28 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id u14sm8442698pfm.80.2020.09.13.18.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 18:49:27 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:49:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v7 05/12] mm: HUGE_VMAP arch support cleanup
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Tang Yizhou <tangyizhou@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zefan Li <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200825145753.529284-1-npiggin@gmail.com>
        <20200825145753.529284-6-npiggin@gmail.com>
        <534a0d5e-3a6f-c8e5-38f9-7e24662acb31@huawei.com>
In-Reply-To: <534a0d5e-3a6f-c8e5-38f9-7e24662acb31@huawei.com>
MIME-Version: 1.0
Message-Id: <1600048125.6soarrvq20.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Tang Yizhou's message of September 11, 2020 8:36 pm:
> On 2020/8/25 22:57, Nicholas Piggin wrote:
>> -int __init arch_ioremap_pud_supported(void)
>> +bool arch_vmap_pud_supported(pgprot_t prot);
>>  {
>>  	/*
>>  	 * Only 4k granule supports level 1 block mappings.
>> @@ -1319,9 +1319,9 @@ int __init arch_ioremap_pud_supported(void)
>>  	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
>>  }
>=20
> There is a compilation error because of the redundant semicolon at arch_v=
map_pud_supported().

Huh thanks, I didn't see that for some reason.

I'll fix it up and re-send.

Thanks,
Nick

