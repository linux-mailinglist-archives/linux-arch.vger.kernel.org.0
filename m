Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB144216604
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 07:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGGFvE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 01:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGGFvD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 01:51:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C29C061755
        for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2020 22:51:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so2133266pld.12
        for <linux-arch@vger.kernel.org>; Mon, 06 Jul 2020 22:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2kPoQO29du6cgYs8wxDy3HydqPoXeUts+rFxoRwvPJ4=;
        b=aC4U6ZGsZUqBz0cWyJxxDDtTiTOjiRRceLssFNvfZVaY6XZ4ahnmh/PWv+zNuf1rG1
         RuIW6sAQLqwYBuidcRZ1HWNwtIt//yvHT15YUMJpu4ViYxTnmxvQJ6mnOnmbbQL0NRKB
         HLVOe98Qp4XwhEu8ZC1qCi2LiON8RrdPy+Me0RZTNidr7XSUy9lpi1ZtkNjxT7JLr2+r
         WYtLfjsdu2giWHeh0UvzEKJBqulTCwDXRXu0aATOoILRBWWLa2Kw+VSzQiWx6gk5S8XS
         nWgnfWl0+w0uiXWBBA+87l+1KIB6YneN+kBCLEn7yAHRoDucikloxmlP6NuDEkiiPVB3
         WCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2kPoQO29du6cgYs8wxDy3HydqPoXeUts+rFxoRwvPJ4=;
        b=d6jcesbsLMWsrwmm0E7Lx/BE3EanDrhq6TZlL3cXfP0gwinLiIV+33hF5dthEXBGEs
         BqlgRq0T48mpTPEtoebqNWScg2HppOKG13ylGphFwWqsSAQV7rwu6ugVDvdQCyD16mHd
         rMjxgxWtNB+8ujfTAtTuiadNNr/uKKEaYTvqgtcrIsdfnQv+Oo2vk5Hu7g6DwIKG65Ne
         H8PMsMp0hnysQ1KQxk2uL2m+GDG3wBDgW6NqJ1bkk6FdmgI11SNkqCjOwCRjHtCvXQ0O
         gcnONlXIlqQ3byBVLAF/CpleT+f0fCcxX7oSfQYS2UcmgqnlgzhPB3dKViDR9ML/pRSY
         MfeA==
X-Gm-Message-State: AOAM530m7AcxCZlhdLt0ZlfUiTRHc5suXE0b2JH4RUQIHabvuSwGlg4d
        H5lsu/5uKkZPNePQqMz9DaGQ0mc8
X-Google-Smtp-Source: ABdhPJx5sV3WSX9SPDMPLTTp0JD9NeJpZpmsKSEOC5s58MfiKeX/NZr+y8YbdNnAg4Rw+uGx8QDvFQ==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr44592437plo.220.1594101063222;
        Mon, 06 Jul 2020 22:51:03 -0700 (PDT)
Received: from localhost (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id c14sm20858247pfj.82.2020.07.06.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:51:02 -0700 (PDT)
Date:   Tue, 07 Jul 2020 15:50:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-arch@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20200706021822.1515189-1-npiggin@gmail.com>
        <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
In-Reply-To: <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1594098302.nadnq2txti.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of July 6, 2020 7:53 pm:
>=20
>=20
> Le 06/07/2020 =C3=A0 04:18, Nicholas Piggin a =C3=A9crit=C2=A0:
>> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/inc=
lude/asm/exception-64s.h
>> index 47bd4ea0837d..b88cb3a989b6 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -68,6 +68,10 @@
>>    *
>>    * The nop instructions allow us to insert one or more instructions to=
 flush the
>>    * L1-D cache when returning to userspace or a guest.
>> + *
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SY=
NC_CORE
>> + * without additional additional synchronisation instructions.
>=20
> This file is dedicated to BOOK3S/64. What about other ones ?
>=20
> On 32 bits, this is also valid as 'rfi' is also context synchronising,=20
> but then why just add some comment in exception-64s.h and only there ?

Yeah you're right, I basically wanted to keep a note there just in case,
because it's possible we would get a less synchronising return (maybe
unlikely with meltdown) or even return from a kernel interrupt using a
something faster (e.g., bctar if we don't use tar register in the kernel
anywhere).

So I wonder where to add the note, entry_32.S and 64e.h as well?

I should actually change the comment for 64-bit because soft masked=20
interrupt replay is an interesting case. I thought it was okay (because=20
the IPI would cause a hard interrupt which does do the rfi) but that=20
should at least be written. The context synchronisation happens before
the Linux IPI function is called, but for the purpose of membarrier I=20
think that is okay (the membarrier just needs to have caused a memory
barrier + context synchronistaion by the time it has done).

Thanks,
Nick
