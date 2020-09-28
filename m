Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBEE27B231
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgI1Qpb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgI1Qpb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Sep 2020 12:45:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C75EC0613CE
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2020 09:45:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so1370204pgi.1
        for <linux-arch@vger.kernel.org>; Mon, 28 Sep 2020 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=k5CJhKG0GbJaPZMSQdNzm2ZEeN1+360gQym/jYiLma0=;
        b=AqQExuufL4ixmO5/UkGibL3PcztVwBX8O7C4i1UIWVFxMUZPsLVdhF5Fjo9eBPQnYt
         j3j3aEfYHBfGQX67Mj2YACZXHEHUVkn9DfAmHWFo0t9w3dn2/D0JbaMFFzM9BZzjcbYX
         PfjtwgMcignt7LJnGbHBMXEbX8Z0AytN8hN5XVj/VfwdFqiwVzkXDW7Mr2GqOP8pYbMF
         TVko7kR9uCWOv/oEZvem9CrM7u3HYAIWIrDh+zLyG3TcRLw5A9ykRx/c8K5ZJu20ylDf
         4180YnTsy1CE/aP/Lu17Hxm4FpOgdq+t4WoGagvXZs36ZwgceawDRcFUBsH1U68uIdD2
         xCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=k5CJhKG0GbJaPZMSQdNzm2ZEeN1+360gQym/jYiLma0=;
        b=stGCrI7UxDVE4eqsVQQyGbJY/z5RIK7T/ISMLZSiUqDn2bfVdwu/pB6j//arAT3mGy
         bBKGflv/daCDhTRFALTklbKmI2Q59uMyOqEHGF9c8jvC6DH1ftOcEipE1UwL9gL7P901
         ZQUB/4C7mxyv1K8vhkdea/BStlW22+w0HIgglyNDsT1PgIivoWP5HeWVdfU79KYhxcYs
         o28E7nSh0GS7jlMnVdG5lYvMeyE1JsFBGYFAuWsvtwPZQQUk/jevKR9gfuCNYaGyA9qe
         Q6XU+pS3crfNB5W7wEF+M+qXcnhou/1DGonNLe83c3JeS5Gf33CxX//M5YVIhC21Be9e
         QDfg==
X-Gm-Message-State: AOAM532+eFgYaOqVhTjOVFzUDDSwEaC9SIzNn89u4rCB1UCCZVBYj3cB
        aymioA+0Tnn+sEd1T8dtFro/HA==
X-Google-Smtp-Source: ABdhPJwJo4C3QCkhpc5E6SNAbf9qW6KUQzb1KDeTrpgbWI5Op/tVKk2PV+95gaM7lOraa7QOH6n1aQ==
X-Received: by 2002:aa7:9f99:0:b029:13e:d13d:a134 with SMTP id z25-20020aa79f990000b029013ed13da134mr284820pfr.28.1601311530896;
        Mon, 28 Sep 2020 09:45:30 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q16sm2392966pfj.117.2020.09.28.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:45:30 -0700 (PDT)
Date:   Mon, 28 Sep 2020 09:45:30 -0700 (PDT)
X-Google-Original-Date: Mon, 28 Sep 2020 09:45:28 PDT (-0700)
Subject:     Re: remove set_fs for riscv v2
In-Reply-To: <20200928124928.GA5834@lst.de>
CC:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-a034d2ee-67eb-4432-be9e-66fff000acda@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Sep 2020 05:49:28 PDT (-0700), Christoph Hellwig wrote:
> On Sat, Sep 26, 2020 at 10:50:52AM -0700, Palmer Dabbelt wrote:
>> On Mon, 21 Sep 2020 21:37:52 PDT (-0700), Christoph Hellwig wrote:
>>> Given tht we've not made much progress with the common branch,
>>> are you fine just picking this up through the riscv tree for 5.10?
>>>
>>> I'll defer other architectures that depend on the common changes to
>>> 5.11 then.
>>
>> I'm OK taking it, but there's a few things I'd like to sort out.  IIRC I put it
>> on a temporary branch over here
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-remove_set_fs
>>
>> under the assumption it might get lost otherwise, but let me know if that's not
>> what you were looking for.
>
> Well, we'll want it in linux-next and then 5.10.  Either a merge through
> the RISC-V maintainer, or as part of the base branch from Al would
> make sense to me.

Sorry, I guess my question was really: does that branch have all the
dependencies necessary for the RISC-V stuff to actually work?  IIRC this actual
patch set depended on some other one, and while I thinK I got everything I
don't want to pull in something broken.

>> Arnd: Are you OK with the asm-generic stuff?  I couldn't find anything in my
>> mail history, so sorry if I just missed it.
>>
>> Al: IIRC the plan here was to have me merge in a feature branch with this
>> stuff, but it'd have to be based on your for-next as there are some
>> dependencies over there.  I see 5ae4998b5d6f ("powerpc: remove address space
>> overrides using set_fs()") in vfs/for-next so I think we should be OK, but let
>> me know if I'm doing something wrong.
