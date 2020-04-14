Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98C1A8045
	for <lists+linux-arch@lfdr.de>; Tue, 14 Apr 2020 16:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405085AbgDNOsW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Apr 2020 10:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404893AbgDNOsT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Apr 2020 10:48:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320DC061A0C;
        Tue, 14 Apr 2020 07:48:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h69so3556867pgc.8;
        Tue, 14 Apr 2020 07:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=L6wwBLpMMetY/zxOEci/JVLuRBV/3LI/LldPvH06RfY=;
        b=jbyVR3i63K7T908IixpVArje1gguIVF9o17an2Ju6P4xd56heYoFmO/WcdvYUGOw83
         7DsRgEXQ7GdDOshFt28h6IZryHi6pCoL9TxpwNMwOPQ1WwJTF7JTL9c2RLAhjn11+Qtp
         81zgUeMjSRjvbeaU+lfmouqsrC6Fr6iqJFDEiznZAV1GOr4656U3Wr5nQootJ2ZQFOWS
         HzUhnCiHoZIIV8+m2lFOeHdd0TIJ4MPu25GdxxAiCtY8PSM3nTP3iBUlJWWpsDaARXRV
         7mWxg96+Qw9Kqu5tSPqHXEfSOUh6hwqt5xIdzBQ9ngUs43LWc7bZzpLIK5dfh+q7KRpc
         C80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=L6wwBLpMMetY/zxOEci/JVLuRBV/3LI/LldPvH06RfY=;
        b=igIZC2ygC1bklltKSTFjfvS57G7cwdVoxJHQ8tO904m9P4HtlpRvG9ixt6nAOUmRsU
         sZ3DqUgWbHU26vnhwcvUUAQtgzvKiHhMILqlSefUP4OmTIQ7FkI+BSP1ScMoOZYZ1Y8k
         BLoxwxc5tATVeqFPH81Gh8qwVZuUC3v62z0J9jAOcMzqBG9zoS41vlrWB4jT2SEU4eSr
         YDxKkVYhfInGk9Ss4WxBHsRTOADWok7GAKrNNmBqgEvmdIPhHe+sRTbyk48eyhuh8Z5z
         FZgLgGRIBeqJ2KpTIhu4nSdU+YS23oaQ9+E8/ELH6KU9vZszzZEqvYtA8CkZallnjdrr
         Nwcg==
X-Gm-Message-State: AGi0PuahLJdpzme9o5s3J/bpqDr6KEYCF10jVsGSw9YP47wJDORRt2GX
        HBf9A9PVfh1nZlcSrsl09BI=
X-Google-Smtp-Source: APiQypK52jNzLdOIfO1gpMRdMkm3ocgjZEpddsb7bx1IdjG1eoLljeSOsDojocPs+NcHrGI7xJxuPA==
X-Received: by 2002:a65:688c:: with SMTP id e12mr1438881pgt.194.1586875698800;
        Tue, 14 Apr 2020 07:48:18 -0700 (PDT)
Received: from localhost ([203.18.28.220])
        by smtp.gmail.com with ESMTPSA id k12sm10439963pgj.33.2020.04.14.07.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:48:17 -0700 (PDT)
Date:   Wed, 15 Apr 2020 00:48:13 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200413125303.423864-1-npiggin@gmail.com>
        <20200413125303.423864-5-npiggin@gmail.com>
        <20200414072316.GA5503@infradead.org>
        <1586864403.0qfilei2ft.astroid@bobo.none>
        <20200414130203.GA20867@infradead.org>
In-Reply-To: <20200414130203.GA20867@infradead.org>
MIME-Version: 1.0
Message-Id: <1586875675.f8q1grbltc.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christoph Hellwig's message of April 14, 2020 11:02 pm:
> On Tue, Apr 14, 2020 at 10:13:44PM +1000, Nicholas Piggin wrote:
>> Which case? Usually the answer would be because you don't want to use
>> contiguous physical memory and/or you don't want to use the linear=20
>> mapping.
>=20
> But with huge pages you do by definition already use large contiguous
> areas.  So you want allocations larger than "small" huge pages but not
> using gigantic pages using vmalloc?

Yes.

Thanks,
Nick
