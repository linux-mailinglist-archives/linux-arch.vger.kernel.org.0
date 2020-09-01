Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF132587F1
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 08:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgIAGRI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 02:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgIAGRH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 02:17:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC9C0612AC;
        Mon, 31 Aug 2020 23:17:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so112095pjv.0;
        Mon, 31 Aug 2020 23:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2o88tY7J6w8zextq4qiLo5rGRfZeNcDDNXs+s2Cv/7g=;
        b=C5JXwJSiEttn0wluZnl7vWYcpSzDIrWO4CJrQHS9m6eRw5flJjAL60Th1U53fSc6Vm
         9F8Vbmjk9AtZ8BX1PKLErIDevNovCtOrZ5tNirWF9X2bYRml0NRv9cWsDS+nI9zh5Upe
         bjZ7GfulZzDg+BL3ub4VqdGfqnUaDnlfIeYE5B5/ZJkR3038fVChfQW8e4bfwhFMCd6b
         r3TrYWqRHvw0j1FBd/3JWVYG9mZ7GlKIB2ybkPGQEDYBEGfx2JNiPHnYF8cfBbeQ49Ro
         KkOAf2Ydk2CcSf4r/XDiK2uAZ+so9r4b1pYQjHhjUR6XnvjKYI0Smi+wni8kMcPWyiJa
         VAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2o88tY7J6w8zextq4qiLo5rGRfZeNcDDNXs+s2Cv/7g=;
        b=GoQNKz0xerd2tCv/MDGKlM/t5RPTgQF14N6cnYbimU8u3h5OyuHIzHFaSqKy7T13RE
         UD7aQAg+gEEOndUCz8FganKz3sNTStiq9+OawjAgwE8LK9ZNpZA+KMLiMlkFUWGjAL/s
         FSE+aTjPlzbWrtK7QyMCnwM86BtcK3pCqmTBdjPtdkKLuT0LhnJOx1cf1Xf6pqyT67Oc
         6kv5kn2GfIs7EPh5mR8kY3klo/e/aboMY2QvqHIx7egdvVB4GES/IrLFi73wwygD4dSS
         oXUXTySAfWTgmD5pz9Gf13pBqnCn5Klc95+3jtSMT0cdQ8AA02g0sMkh8j62Jj4cPcfW
         0YVA==
X-Gm-Message-State: AOAM532FYLqbW/QK5Fli3xzF9nMfgZ4c98vToUNgebd1crDoBi1SOjvT
        IMX8mlggTb0xDq5b+KejIlsglJ8CrBo=
X-Google-Smtp-Source: ABdhPJwimDjXGqDUTGorUJk5RKuAeUTUHlriv+xqEennIpezTOJocleqS5z31PE/+eNhK2Zuecj2Qw==
X-Received: by 2002:a17:90a:5609:: with SMTP id r9mr109290pjf.194.1598941026511;
        Mon, 31 Aug 2020 23:17:06 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id j12sm228691pjd.44.2020.08.31.23.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 23:17:06 -0700 (PDT)
Date:   Tue, 01 Sep 2020 16:17:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/23] Use asm-generic for mmu_context no-op functions
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200826145249.745432-1-npiggin@gmail.com>
        <20200830101837.GB423750@kernel.org>
In-Reply-To: <20200830101837.GB423750@kernel.org>
MIME-Version: 1.0
Message-Id: <1598940942.o1fbygdcvl.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Mike Rapoport's message of August 30, 2020 8:18 pm:
> On Thu, Aug 27, 2020 at 12:52:26AM +1000, Nicholas Piggin wrote:
>> It would be nice to be able to modify mmu_context functions or add a
>> hook without updating all architectures, many of which will be no-ops.
>>=20
>> The motivation for this series is a change to lazy mmu handling, but
>> this series stands on its own as a good cleanup whether or not we end
>> up making that change.
>=20
> I really like this series, I just have some small comments in reply to
> patch 1, otherwise feel free to add
>=20
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

I can't see your comments in reply to patch 1.

Thanks,
Nick

