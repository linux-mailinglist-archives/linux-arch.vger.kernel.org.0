Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792E12530E4
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHZOHI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbgHZOGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 10:06:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC19C06179B;
        Wed, 26 Aug 2020 06:59:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so932765plr.5;
        Wed, 26 Aug 2020 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=j6Uv5RjTZheoZG1YfQDcy1TspSIOLnzYmIYWVtUuEuo=;
        b=CZQ5KFoKO9q5uJ/EwZfMmag4/nN9uPr+FfoxZDRG7giS7ouwVpR+YsRFZkimpYW0/O
         3If9gqRqlqXOtKh+vBTSRdxLKOszwzbHjb0+8F6FophLYBh9VUNvlT4jKlYMR9h+jnwo
         h4Xzh/P2pOXMp+9fifvK4RLonERZrUzCQs2Zi+Qegg4XOtKT3NaM3sYczrjUzDcHQ5kA
         aODoBTnH68o7Ce7/IsAwowU4hFgsakMhANkESPO7mSsrk3jJ39dlEflGfo7438PIQGip
         sT/tOy/fB/tFnsvifmWHbkrIsZT4oWR++jClH9iblTtpgR6MZZQBBWZ+PDOz5vYDH0qd
         QSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=j6Uv5RjTZheoZG1YfQDcy1TspSIOLnzYmIYWVtUuEuo=;
        b=qjsd2ZqTFKOEMUgmBwWzqZSFoE0GALwLHrHCyJFGT5kqLP8YMyRgm6drSeuoq5mFZF
         5pyoJo+2DCiWbrnpi6sF/oYE4Ga5Jk1dqiicp+zmnbqUqgnNM2b0esi2Nt87Qmj+tyqt
         OHHDOS2NPKBvIsm9DhhcDc9H/vl0yUJpPi+SjRE4wJsfY1O89L9ufmwOiU9uku8CopdE
         chF3OUKBP+SO/99C6FzgZPyzefnlLGYQnwu/1bxs/s137OkupoFS3IKbIPjIDWMnopvl
         kF2d8yxlc2TlTN3RvXURXWDdFD4DJtCuVkdDIx3n2WBonTzHkt0PuzwJfCB1AP/O1m83
         bpYA==
X-Gm-Message-State: AOAM533Jgsca2s9mJf3eQ4afcTh0wStGmKrnS3Qnj2ywtkeNOaJoktGz
        baoZXzALFJFa5J61BT5/JphcSMtMEIA=
X-Google-Smtp-Source: ABdhPJxG86D/OE+V3vgMRPaY6avWnnT+Kp7k9+ye+aWzx0L/7bPIEQK+hdND7TfE9W+QJibYUhQvyg==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr12180075ply.106.1598450357439;
        Wed, 26 Aug 2020 06:59:17 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id q82sm3411353pfc.139.2020.08.26.06.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:59:16 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:59:11 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/24] asm-generic: add generic versions of mmu context
 functions
To:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20200728033405.78469-1-npiggin@gmail.com>
        <20200728033405.78469-2-npiggin@gmail.com>
        <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
In-Reply-To: <12ac3789-71a5-2756-6a9e-769302c7b3c6@synopsys.com>
MIME-Version: 1.0
Message-Id: <1598448101.l98ljfhzbg.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Vineet Gupta's message of July 28, 2020 2:01 pm:
> On 7/27/20 8:33 PM, Nicholas Piggin wrote:
>> Many of these are no-ops on many architectures, so extend mmu_context.h
>> to cover MMU and NOMMU, and split the NOMMU bits out to nommu_context.h
>>=20
>=20
>> -static inline void switch_mm(struct mm_struct *prev,
>> -			struct mm_struct *next,
>> -			struct task_struct *tsk)
>> +/**
>> + * activate_mm - called after exec switches the current task to a new m=
m, to switch to it
>> + * @prev_mm: previous mm of this task
>> + * @next_mm: new mm
>> + */
>> +#ifndef activate_mm
>> +static inline void activate_mm(struct mm_struct *prev_mm,
>> +			       struct mm_struct *next_mm)
>>  {
>> +	switch_mm(prev_mm, next_mm, current);
>>  }
>> +#endif
>=20
> Is activate_mm() really needed now. It seems most arches have
>    activate_mm(p, n) -> switch_mm(p, n, NULL)

Alpha, nios2, parisc, s390, um, x86 have non-trivial differences,
so it seems to be still needed.

Thanks,
Nick
