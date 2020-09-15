Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7D269C7F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Sep 2020 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgIODYP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 23:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgIODYO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 23:24:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47614C06174A;
        Mon, 14 Sep 2020 20:24:13 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg9so607821plb.2;
        Mon, 14 Sep 2020 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=irbkPgnfVyWMQHxRCFB56no1LsWgtr4nyisml0hvN5M=;
        b=czG0uxgtgmPzrOOxLt4QmLQjK9z2MyB/I3cVw41+bQI4inEF/0imI47qizBZzP9IGA
         aBeVvkgZgvUlmGO2x8HpojXnjrb/SGdRb+rxGVk5Hi+J75XNmSIBsJm+ELSzvsps7+iM
         PlzLu7vx2uxw8UhKzIJFQ0gG7dMa+Lrl/iexLy9ADk/w8PHdlJk55PaKztDmo2caxnDM
         uuAx55TUPcqvnCij2WTA3qURpI03MY7RB1Kd4/9YOpa6Uu6mvRlmkJx4/oWQOQ08OxNN
         pOQiS+d6LMOl95lawfzdaUZZiaSJmAfMgbX/vN6C0ESuYiXRkUOiP/GTSg15ZiE8vcuZ
         0mXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=irbkPgnfVyWMQHxRCFB56no1LsWgtr4nyisml0hvN5M=;
        b=IWOaZ0s227jiKdTjIymmzP23F5Itcmhl41V+M3PuGbBkjU3+VR6WyTxu5YUkqKcBXF
         NfVkg3/zcH3jQ9kYvnsGE/xF3izg/LuFPeEw5YBn3B3kNpIQ99k0GPIBPaqCnspwipBF
         vXPwC+0NYJ2TrBlo/OqpQkJr7Trv1nvHlEbwvqXCytuSMXROep9XY+eMe/E2V5COGdjb
         eUqhOIv4p43z1qn5abqA0/gXS+ugxlEgsBVoavphNSbdAc+DlzwKEutELG8VwZGWoikh
         QbzBYqFIPOXLtgUF/Z7SZRm7cdncei8JY+e7Zwd0F6+K87wFlOHiHTg2dau0WuhgXvsj
         RHdw==
X-Gm-Message-State: AOAM530WcFofn8CuQcNWI5lCX9ypwkUSAHkNyfdx5DpSUFCsZ3Vgno8r
        6+BoDczhJ9RWG/qfAtWWqSU=
X-Google-Smtp-Source: ABdhPJySSgYe8lF/6JDS960pKpGJxF72ZmNu6Ie+xgS/tQum+ZxCJr6+X0CzlaFCQ2vkb+wTaG3xAA==
X-Received: by 2002:a17:90a:6e45:: with SMTP id s5mr2238591pjm.12.1600140252750;
        Mon, 14 Sep 2020 20:24:12 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id b20sm12442113pfb.198.2020.09.14.20.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:24:12 -0700 (PDT)
Date:   Tue, 15 Sep 2020 13:24:07 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/4] sparc64: remove mm_cpumask clearing to fix
 kthread_use_mm race
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        axboe@kernel.dk, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        sparclinux@vger.kernel.org
References: <20200914045219.3736466-1-npiggin@gmail.com>
        <20200914045219.3736466-4-npiggin@gmail.com>
        <20200914.125942.5644261129883859.davem@davemloft.net>
In-Reply-To: <20200914.125942.5644261129883859.davem@davemloft.net>
MIME-Version: 1.0
Message-Id: <1600139445.qwycwjuwdq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from David Miller's message of September 15, 2020 5:59 am:
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Mon, 14 Sep 2020 14:52:18 +1000
>=20
>  ...
>> The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
>> optimisation could be effectively restored by sending IPIs to mm_cpumask
>> members and having them remove themselves from mm_cpumask. This is more
>> tricky so I leave it as an exercise for someone with a sparc64 SMP.
>> powerpc has a (currently similarly broken) example.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Sad to see this optimization go away, but what can I do:
>=20
> Acked-by: David S. Miller <davem@davemloft.net>
>=20

Thanks Dave, any objection if we merge this via the powerpc tree
to keep the commits together?

Thanks,
Nick
