Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8310351DA98
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442214AbiEFOi0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343536AbiEFOiY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:38:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D29692A0
        for <linux-arch@vger.kernel.org>; Fri,  6 May 2022 07:34:41 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c14so6415707pfn.2
        for <linux-arch@vger.kernel.org>; Fri, 06 May 2022 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7u3OwSkyFfQPtUMBSXJ+m0o3AIK+1qwz0/mjtmfCQB0=;
        b=FdeTUfLPDw9k8X6pTEaLv52yUet9VfSQ7bi4HQ1t2xxaDysAJZFgQ7VRrYNlmPjTaj
         2tZL8ukYEo7mNc766P4NQqVT9VU4xcQVvoq18pPjJEP+0zEMAny+6Y6R1wOkE1tgO1wN
         uO8kog1rHC8+u41oS0ocTQzuT0i21hJ3Uz5f+CifLuIMIngaK02mJcE8pu1U5afhbLJI
         DQvD2wdX+c/IHeRxzEhPxhM8zCujiWsHkyNF2bZlVm+qDJtsTHgLYuDntTJYuurXEomy
         6N6H/Q1iuEHCKEfOxPpaFPLiJqifIcesYahJuQ4SUdI1fRp5qzJFzMshG8VThV3XD+0t
         zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7u3OwSkyFfQPtUMBSXJ+m0o3AIK+1qwz0/mjtmfCQB0=;
        b=6R1OzQL54o3sha0YO8GpuIGcjSP3OyqRMWmJwVwk6QZds0rBtKcWf1bWtOVRG858z/
         naABLltRMrJD/igwEDVnkyx5HLLalj8ISp1hYh1UBQeLKYNa8eJUicXE0A+X3Z/fdnbv
         zN1rrh7kPEGLN92EKLakATcFwe+nOSOuIgcFmiX6LrQQPmPpnugQafk1p9Y/RmK/IFlK
         9Iv/6FJXE5+rLlmQyCdxQKJSBh3Hs57Zyi/DcWIF47tlt6EeADxTSQSLSnE/haCYobgW
         NP6TGm70NjG7LRAzQH6hGG9eS6OlrvAWobDRH76f6IpDfdOMVtAr4JahWRpo48iqTukT
         v1ZQ==
X-Gm-Message-State: AOAM532Sj7S3ILgDgwAw0QfIHCm4Nx/ObxEYXC9qS5bgjwH1V0PoIO5w
        HI1Rj6/t3Z/HfmWxS/0Pkv2+aw==
X-Google-Smtp-Source: ABdhPJxRyjLgEf03HBpUE/mZuN6gq4KYh/avgT4q6TfXPSIwYir1NJqPKE0fyCteJUZc4c2jSgcLGw==
X-Received: by 2002:a63:d00b:0:b0:3c1:6c87:2135 with SMTP id z11-20020a63d00b000000b003c16c872135mr2936313pgf.93.1651847681336;
        Fri, 06 May 2022 07:34:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a21-20020a170902ee9500b0015e8d4eb241sm1820885pld.139.2022.05.06.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 07:34:41 -0700 (PDT)
Date:   Fri, 06 May 2022 07:34:41 -0700 (PDT)
X-Google-Original-Date: Fri, 06 May 2022 07:34:18 PDT (-0700)
Subject:     Re: [PATCH v4 0/7] Generic Ticket Spinlocks
In-Reply-To: <CAK8P3a1VjunJE5zAm96pkQX7EvVDcN6VGT8usedeO709KQnB_g@mail.gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, macro@orcam.me.uk, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-2750a5d4-cb79-4142-a8c6-e7e0c80f8e85@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 05 May 2022 04:09:46 PDT (-0700), Arnd Bergmann wrote:
> On Sat, Apr 30, 2022 at 5:36 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> Comments on the v3 looked pretty straight-forward, essentially just that
>> RCsc issue I'd missed from the v2 and some cleanups.  A part of the
>> discussion some additional possible cleanups came up related to the
>> qrwlock headers, but I hadn't looked at those yet and I had already
>> handled everything else.  This went on the back burner, but given that
>> LoongArch appears to want to use it for their new port I think it's best
>> to just run with this and defer the other cleanups until later.
>>
>> I've placed the whole patch set at palmer/tspinlock-v4, and also tagged
>> the asm-generic bits as generic-ticket-spinlocks-v4.  Ideally I'd like
>> to take that, along with the RISC-V patches, into my tree as there's
>> some RISC-V specific testing before things land in linux-next.  This
>> passes all my testing, but I'll hold off until merging things anywhere
>> else to make sure everyone has time to look.  There's no rush on my end
>> for this one, but I don't want to block LoongArch so I'll try to stay a
>> bit more on top of this one.
>
> I took another look as well and everything seems fine. I had expected
> that I would merge it into the asm-generic tree first and did not bother
> sending a separate Reviewed-by tag, but I agree that it's best if you
> create the branch.
>
> Can you add 'Reviewed-by: Arnd Bergmann <arnd@arndb.de>'
> to each patch and send me a pull request for a v5 tag so we can
> merge that into both the riscv and the asm-generic trees?

Yep.  There were some other minor comments, I'll clean those up as well 
and send something soon.
