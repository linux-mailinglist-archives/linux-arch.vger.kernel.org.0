Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568C1221925
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 02:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGPA4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 20:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPA4Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 20:56:25 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE4C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:56:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so5005342wrp.10
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2yXBU/Ro8tt3BMItLRDJ51kVPVxKauTptO3mkGGJBA4=;
        b=QXuNLNNcbcHCJVKlyt3ec4nFlNxed6bkOpNVCbyGT7xIP/sLLVIq/KuURownPgDMTQ
         nWneOJp811fwyZzhgR59lFbINHKxJvwRO5kJAHWGu4d4tPzdlVW+zfuyjml5SeO8Vpr3
         SN6hivQ4UCDd7mP/awJtIju0u7uxAzwEEoukb+GSkrK3oP1pCAe0b+vS0zdbdjNnwnoW
         zds/+Gc02beJQZ9G7VsVHIjIBeaI8bpGCDgEopzpyIeokcz/rIIs2HCOai38BHq9pI65
         vDqqSj35soma+l7UX0Gr/L7+B78RU0InawD/iglXDWrW6dk1M6BUlQ1x5VXekLrMvdp5
         9AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2yXBU/Ro8tt3BMItLRDJ51kVPVxKauTptO3mkGGJBA4=;
        b=H+zWeik7dxZyUlL7wORlBmvp4KivMnwk6sm2VQeB/enIPoJGFFJUIWtaypFxgljdJa
         N1VLXPeDpaqkf6Myx3PcCpcnhR+5hmOVRf88NHHuKlMFlRFMAQmWzgpjtlJLXW2N6aNt
         9lpQq9AXAsD5l9MixgyZroe9oDM7QcP5VeFyEpB1lVLd2Q+dnDAt6vgMHeKfokALgYCP
         n/ocbP2nzphgvx8qLXpiYjmArv67odjOgmiPPfSRqdYjYIzqsggHnOhNePMdaCttMuQV
         zEElpXoSDZQR9k3TZYmFY7cScFd9lwhZX6dsuoC14TpT/F1+x7fDBF23DQOcQsvIowFq
         jZvQ==
X-Gm-Message-State: AOAM533fW4OoRRzO6UpnfGNPhphpKUkgcfuKO1SJj5zC0rbB8S4KtWe+
        pmgF8R7H96WCRtyTYuJ5PnjcsIaa
X-Google-Smtp-Source: ABdhPJx06UjsWIdLtjR7AmKB7TrwI2JGoDMROl1S5T12YFHnWm6rbD6Kaz05BiLjXNc4lP2OXQ5Dmw==
X-Received: by 2002:a5d:63ce:: with SMTP id c14mr2411824wrw.254.1594860983680;
        Wed, 15 Jul 2020 17:56:23 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id n14sm5774398wro.81.2020.07.15.17.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 17:56:23 -0700 (PDT)
Date:   Thu, 16 Jul 2020 10:56:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     =?iso-8859-1?q?Christophe=0A?= Leroy 
        <christophe.leroy@csgroup.eu>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20200715094829.252208-1-npiggin@gmail.com>
        <87zh816qgv.fsf@igel.home>
In-Reply-To: <87zh816qgv.fsf@igel.home>
MIME-Version: 1.0
Message-Id: <1594860957.3hoocg9gu6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andreas Schwab's message of July 15, 2020 8:08 pm:
> On Jul 15 2020, Nicholas Piggin wrote:
>=20
>> diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/inc=
lude/asm/exception-64e.h
>> index 54a98ef7d7fe..071d7ccb830f 100644
>> --- a/arch/powerpc/include/asm/exception-64e.h
>> +++ b/arch/powerpc/include/asm/exception-64e.h
>> @@ -204,7 +204,11 @@ exc_##label##_book3e:
>>  	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
>>  	ori	r3,r3,vector_offset@l;		\
>>  	mtspr	SPRN_IVOR##vector_number,r3;
>> -
>> +/*
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which rfi is) to support ARCH_HAS_MEMBARRIER_SYNC_CORE without addi=
tional
>> + * additional synchronisation instructions.
>=20
> s/additonal//

Will fix in a respin.

Thanks,
Nick
