Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C827C45F382
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 19:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhKZSMC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 13:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbhKZSKC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2021 13:10:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3424CC06175A;
        Fri, 26 Nov 2021 09:49:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gt5so7628434pjb.1;
        Fri, 26 Nov 2021 09:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=83Ooe8dPRyWeyhXmj6GcJq82Gt4gb3ZK5M8zZoiOi6Q=;
        b=ochLAJ3Tebzo4peAZr1LDip7BLAMFnWXVx8lGWP33dzdz1kWUtWraUbZ4yea+hXub6
         gEp1JcVQeKKGGC8fl503t+xIZjfPDx5v0dInww3tJsBHcfgFKuv8+MfUZEnWWB3emNHV
         6ju6ae0IWKqbz2hmHU3WzJEukxblaIzjWTGHTfeMeKBBRkaHVLGO79L4NcGTClpWhf+7
         pN7VERZShQl1p3VUGiS3t25l1wQZJtFHqDHghMd1idDx4wz9uV1/axtfrzsEbsQpAHCM
         UGqhdY4PVX1ypkcamBXzVkeutbHd8gx5Sq1Q2ztLTeLXr+s4Yo585ug8GMoCR+MA59WY
         vr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=83Ooe8dPRyWeyhXmj6GcJq82Gt4gb3ZK5M8zZoiOi6Q=;
        b=XbnF44QT5mPfN8GkNomVeqT+xPjOIvxs7KAo94cBnCm7UZO9qJx6oE2bRgDDfMexGT
         LXQ1Uqgq2S9YHQO6Ie3ok+nL8SU6frGQOUB1W44NNmx8dQg5SMI+EciSaRGnuFHwxSmi
         KMjAIdPysMngCjGw0l7mI7lWiVD05XFR/yGhc2ZENjypNTBkzTZlObDcTRw1I/Kpdtns
         syGNAGBWHWV7X7+RCbmxrJ2+pTB5UE3EuOWQWeEffEEyyjQlfY7oqnzZ2jzInvYe0Frd
         xJJd3jrgaCtcX8EvGR3vm29S0/N7jFR+NnVFqxA7i9MHCefoocZ7loHIwgMqMdKSdlMt
         29hQ==
X-Gm-Message-State: AOAM532h63OuaAcxrYVB2j5Ia7ZJUJlgab4u88KSdhYeBLRw6QJjDufE
        n091+lHHGJk8qu7ZyFwrZuc=
X-Google-Smtp-Source: ABdhPJwcXwkyAd2pP43UXtFP8PkXixg5BhcHiUdfmXY3aw+C6FVmnnrhz5xOhxUMVxip/s6pkbFtQA==
X-Received: by 2002:a17:902:da85:b0:142:11b4:b5c0 with SMTP id j5-20020a170902da8500b0014211b4b5c0mr39890004plx.53.1637948944384;
        Fri, 26 Nov 2021 09:49:04 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id d7sm8340781pfj.91.2021.11.26.09.49.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 09:49:03 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 4.9] hugetlbfs: flush TLBs correctly after
 huge_pmd_unshare
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <7a2feed4-7c73-c7ad-881e-c980235c8293@cambridgegreys.com>
Date:   Fri, 26 Nov 2021 09:49:01 -0800
Cc:     Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1607574-0A6F-4CEC-B488-795750EEF968@gmail.com>
References: <3BD89231-2CB9-4CE5-B0FA-5B58419D7CB8@gmail.com>
 <7a2feed4-7c73-c7ad-881e-c980235c8293@cambridgegreys.com>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Nov 26, 2021, at 2:21 AM, Anton Ivanov =
<anton.ivanov@cambridgegreys.com> wrote:
>=20
>=20
>=20
> On 26/11/2021 06:08, Nadav Amit wrote:
>> Below is a patch to address CVE-2021-4002 [1] that I created to =
backport
>> to 4.9. The stable kernels of 4.14 and prior ones do not have unified
>> TLB flushing code, and I managed to mess up the arch code a couple of
>> times.
>> Now that the CVE is public, I would appreciate your review of this
>> patch. I send 4.9 for review - the other ones (4.14 and prior) are
>> pretty similar.
>> [1] https://www.openwall.com/lists/oss-security/2021/11/25/1
>> Thanks,
>> Nadav
>=20
> I do not quite see the rationale for patching um
>=20
> It supports only standard size pages. You should not be able to map a =
huge page there (and hugetlbfs).
>=20
> I have "non-standard page size" somewhere towards the end of my queue, =
but it keeps falling through - not enough spare time to work on it.

Thanks for your review.

I did not look at the dependencies, so I did not even look if
hugetlbfs depends on !um.

Do you prefer that for um, I will just do a BUG()? I prefer
to have a stub just to avoid potential build issues.

