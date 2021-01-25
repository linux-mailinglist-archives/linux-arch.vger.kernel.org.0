Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FB43034A7
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 06:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbhAZFZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbhAYMKU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 07:10:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D78C0617AB;
        Mon, 25 Jan 2021 03:37:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id q2so4661359plk.4;
        Mon, 25 Jan 2021 03:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=lyJL5RmrtYo3SR2xmnLNbqSqvpRFTAglsJ8iapGc2cU=;
        b=vcl7mmpM9cZo4dan8q3yYSJT0AyPGuHr3thpLqcrviOPOA41GAV3uo8D9VYuRQpTEp
         NnWoNXgf7XiKyty0VOn5VbeqVuykZioqekTbXVF9PKingcpZ9ZPskR2CmcKT8oTmuwq/
         T7qFyq/23apKBb45YIT2xz4SPpF9AB8Kb3QAjtbIe+yEEWKAQ/ST0g9B4M8UN6ZKWTad
         As/BPdDcOaHyjYZWsaiMuOVWMDVK62za1SQeWu83BrFJQr3s2JJjNNU/VaFp8qR4nLhm
         v5VdwwKX77foe4XldOYA1/2BzkKBNx8Kg36s6ydAN2/eKN6RPp/NsH2Ml6W6IQffgDCG
         ZeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=lyJL5RmrtYo3SR2xmnLNbqSqvpRFTAglsJ8iapGc2cU=;
        b=aVfQ2uAAIHZtsUHYXwZf4a4iXRndstFr3HutkVIscj1OWjCCouMOkDRSNmJ++9UMXa
         KPnHLMqh4XKUVryOND+Fu3nvuV7hGJY9qx6Bm9nyeCnYSB5869W5x4mmJWoCLuk+ojC/
         FEVKd6GYBbBqkC4Q9nbCA9Z3vya0LF1cgRjW07GRRk0Pp/JUaooDcGq07jkrWNOGmzuV
         MK586NvrSsYnoFPOpLt1DoI+Rz16piWHswBrp+fNY02aSKL1PsJC70YwQ/djVlZRT+s5
         RjngEyYE+qZMAsqiaeuP/o0ru2B8GLfH1nt6zvCBbHjdCJnCisCGNle3rZ7uD2Y/A9cr
         4xBQ==
X-Gm-Message-State: AOAM533lXQ4PFvi07zLvdHu05euh+9vtYCQIvxaOmZOP3e0hHfF2sNzW
        kC9AhzxyOm9ttGuSP4HHScs=
X-Google-Smtp-Source: ABdhPJwQaEG7os5ttUkuIQn0Krrn6BcNJkyonQbGJcEmjaCMBQ8fY8SMo+YBjwAoUiTKyR2QsVZxLg==
X-Received: by 2002:a17:902:59c1:b029:df:fd49:f08d with SMTP id d1-20020a17090259c1b02900dffd49f08dmr200075plj.76.1611574636100;
        Mon, 25 Jan 2021 03:37:16 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id x125sm13108821pfd.17.2021.01.25.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 03:37:14 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:37:08 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 06/12] powerpc: inline huge vmap supported functions
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-mm@kvack.org
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
        <20210124082230.2118861-7-npiggin@gmail.com>
        <c03010a7-a358-0321-d5d4-80a770c2213f@csgroup.eu>
In-Reply-To: <c03010a7-a358-0321-d5d4-80a770c2213f@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1611574452.y64320stks.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of January 25, 2021 6:42 pm:
>=20
>=20
> Le 24/01/2021 =C3=A0 09:22, Nicholas Piggin a =C3=A9crit=C2=A0:
>> This allows unsupported levels to be constant folded away, and so
>> p4d_free_pud_page can be removed because it's no longer linked to.
>=20
> Ah, ok, you did it here. Why not squashing this patch into patch 5 direct=
ly ?

To reduce arch code movement in the first patch and split up these arch
patches to get separate acks for them.

Maybe overkill for these changes but doesn't hurt I think.

Thanks,
Nick
