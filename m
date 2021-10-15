Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B673942E8AF
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 08:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhJOGNo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 02:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhJOGNo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Oct 2021 02:13:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABABC061570;
        Thu, 14 Oct 2021 23:11:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so6526595pjb.5;
        Thu, 14 Oct 2021 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=plfcm4CfcUE1WiY9y7riQIhpNSbgCl5IoHQbTDcGsFg=;
        b=gieWljbKJwM9dQX6FOXQV2SpCe//Ev5ww9pOhDg5EdDrNtR5Lx0ZAL812Gu332zPKR
         UI7yMIUPu2HyloFVswy9HgPPvtbyrdczGYvnoHYakywHAaViHzL5uqFUKrFbnusGE78p
         FR7XkKvoEOhCvlYUoeVZCxWBtLpfk7zmIJS58MkCHqCV+yC9MSjQFbhk5uVvUNGtWoP6
         NrG607qHVb55hKbFALyOZNpJTTziAS3sgyN27QNIhMeIclv5SsR4MDwB3hEMWWp7mZzz
         voySiAUFzvMaQB1oVslqz1NbLZ/onJvkQWpytWvGSHGyROoBeqZyXvFF/H15Cw767WGu
         2/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=plfcm4CfcUE1WiY9y7riQIhpNSbgCl5IoHQbTDcGsFg=;
        b=lqugmgCjPHrwsJ3ptFr8Ujez7DlNezSvuLjq31CnBklTuPIXbqpeHIl5JHxXInslPY
         QskJTDo67gfkItu98HiJ70EQiylPsAavn7QJcHgvos2snFn1+9rWUN62hePCqVfS9FMa
         LeD7PNZj+T+7nStF2+dKAfvWCVcxQwNO7difvCI/akCoouTigUwS9IZ3rHX9KVSFTSD7
         FzTEd3Ouhg/pXge7/alSrz6224MvaDfRhE0eY+OX3HHxzsXL12Vnelgn2+cAWGzRIQg2
         +Q+cNUdet7LtDP09G6zCam2KGJe4mBMG8bdgQEdkxwwVpzZ0Vjb/4YGv4sdccWt6Iqc0
         ttqw==
X-Gm-Message-State: AOAM531w2I3JnznH5w0eU052r0s1LT92FO9zMRpEPY8y5R34ua9NozFv
        R4p0OvfB8nIinJ6hds7oOyA=
X-Google-Smtp-Source: ABdhPJw1NnFiRHA+uTmys9crR/a3G0Uc+wC/8h4OyGNNK2GxtvT1XWJX/yFt1VyNaMubShrCkR00uw==
X-Received: by 2002:a17:902:6f01:b0:138:9aca:efda with SMTP id w1-20020a1709026f0100b001389acaefdamr9600787plk.19.1634278297562;
        Thu, 14 Oct 2021 23:11:37 -0700 (PDT)
Received: from localhost (14-203-144-177.static.tpgi.com.au. [14.203.144.177])
        by smtp.gmail.com with ESMTPSA id s22sm4032847pfe.76.2021.10.14.23.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 23:11:37 -0700 (PDT)
Date:   Fri, 15 Oct 2021 16:11:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 03/13] powerpc: Remove func_descr_t
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Helge Deller <deller@gmx.de>, Daniel Axtens <dja@axtens.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
        <16eef6afbf7322d0c07760ebf827b8f9f50f7c6e.1634190022.git.christophe.leroy@csgroup.eu>
        <874k9j45fm.fsf@dja-thinkpad.axtens.net>
        <b02d5211-2f00-b303-766b-d612c1bd4402@csgroup.eu>
In-Reply-To: <b02d5211-2f00-b303-766b-d612c1bd4402@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1634277766.29y8aqzatr.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Christophe Leroy's message of October 15, 2021 3:19 pm:
>=20
>=20
> Le 15/10/2021 =C3=A0 00:17, Daniel Axtens a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>=20
>>> 'func_descr_t' is redundant with 'struct ppc64_opd_entry'
>>=20
>> So, if I understand the overall direction of the series, you're
>> consolidating powerpc around one single type for function descriptors,
>> and then you're creating a generic typedef so that generic code can
>> always do ((func_desc_t)x)->addr to get the address of a function out of
>> a function descriptor regardless of arch. (And regardless of whether the
>> arch uses function descriptors or not.)
>=20
> An architecture not using function descriptors won't do much with=20
> ((func_desc_t *)x)->addr. This is just done to allow building stuff=20
> regardless.
>=20
> I prefer something like
>=20
> 	if (have_function_descriptors())
> 		addr =3D (func_desc_t *)ptr)->addr;
> 	else
> 		addr =3D ptr;

If you make a generic data type for architectures without function=20
descriptors as such

typedef struct func_desc {
    char addr[0];
} func_desc_t;

Then you can do that with no if. The downside is your addr has to be=20
char * and it's maybe not helpful to be so "clever".

>>   - why pick ppc64_opd_entry over func_descr_t?
>=20
> Good question. At the begining it was because it was in UAPI headers,=20
> and also because it was the one used in our=20
> dereference_function_descriptor().
>=20
> But at the end maybe that's not the more logical choice. I need to look=20
> a bit more.

I would prefer the func_descr_t (with 'toc' and 'env') if you're going=20
to change it.

Thanks,
Nick
