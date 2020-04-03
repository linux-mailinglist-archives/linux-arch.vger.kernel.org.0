Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1224119D576
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 13:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgDCLFk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 07:05:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40727 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCLFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 07:05:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so3351151pgj.7;
        Fri, 03 Apr 2020 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=x9Gh9Ne5hehOj6WK8fXAryOv2SRTsZsEIVDa4lvYavs=;
        b=QKJvx6WRjaROA10YzVatzEwmmznxq1ITVAMtYv++ze5uDv6j6xOlVP/VNt6ue3kGoY
         RBLVfU2HTNBI9fO4q81SJ38mUb+pfV1StfjzDocjBaFe4AkswiIL76gv/peKsu2JzD0W
         0+EINrDhU3d/1Ow/OKrXq1kcha/YwfD+6mP0Bi4AiDj2RaC1OlBu3S6+62+lfuXER/0v
         MDVzsst4lRcxBrHTk08NVs+VpRMQcSD6TB5ad+yejWecUIOk1HJ8Z77es0Cw0/8+mgRy
         QndZDBm44syZEy6UnKyMzdFV34SZgn0K7pRuc1ueFiMSvVy0bgyCOcwNPZBctt+rJEDr
         VUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=x9Gh9Ne5hehOj6WK8fXAryOv2SRTsZsEIVDa4lvYavs=;
        b=uFhUJHH2sQgi/IoqR6tvXR9BErVhKtknIzRF2vMc0htVwthSTfgdla9WGUBr6mHxGU
         rPb4RlJfxPujkvHfdu4W7Xq/EFYch199WaLfAWV1iJMs21VPenLIiF5tgJGWDZ0GTx5J
         lsdA1ehOWYsqpToZSd0QWm63tgT08m7FG1yIOqR1Se0VPtJ141qSsqmXsedsbm0BRXBL
         3lH9GHdCBN6vIaWm9DWogLv9lpCo30axWqWHQ4U/cgJqv5hHyB/STgDbXqVzpXctKCC3
         Q4AjXw0YsNC/LC42Ski4sNouyVC/J7Xf20E2ZKjxAPXs5z7LKta4/+7PvAgXobNJI+0s
         81/Q==
X-Gm-Message-State: AGi0PuaITMrO6G+JhOPBrNGki9+FJ5VjUbxxBM9IaqtU4+XVkOZd4Z+w
        2aBnsztUInFtJGnE6bZ3acM=
X-Google-Smtp-Source: APiQypITP86igCzfZB/PGqJtrjO/2PRknSxfizUBsnugT9boahO/Sg8qOx8MOCUdCQzhs+hzbU239A==
X-Received: by 2002:a62:19d8:: with SMTP id 207mr8084940pfz.278.1585911937914;
        Fri, 03 Apr 2020 04:05:37 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id w15sm5607378pfj.28.2020.04.03.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 04:05:36 -0700 (PDT)
Date:   Fri, 03 Apr 2020 21:05:26 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/64s: implement probe_kernel_read/write
 without touching AMR
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20200403093529.43587-1-npiggin@gmail.com>
        <558b6131-60b4-98b7-dc40-25d8dacea05a@c-s.fr>
In-Reply-To: <558b6131-60b4-98b7-dc40-25d8dacea05a@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1585911072.njtr9qmios.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy's on April 3, 2020 8:31 pm:
>=20
>=20
> Le 03/04/2020 =C3=A0 11:35, Nicholas Piggin a =C3=A9crit=C2=A0:
>> There is no need to allow user accesses when probing kernel addresses.
>=20
> I just discovered the following commit=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D75a1a607bb7e6d918be3aca11ec2214a275392f4
>=20
> This commit adds probe_kernel_read_strict() and probe_kernel_write_strict=
().
>=20
> When reading the commit log, I understand that probe_kernel_read() may=20
> be used to access some user memory. Which will not work anymore with=20
> your patch.

Hmm, I looked at _strict but obviously not hard enough. Good catch.

I don't think probe_kernel_read() should ever access user memory,
the comment certainly says it doesn't, but that patch sort of implies
that they do.

I think it's wrong. The non-_strict maybe could return userspace data to=20
you if you did pass a user address? I don't see why that shouldn't just=20
be disallowed always though.

And if the _strict version is required to be safe, then it seems like a
bug or security issue to just allow everyone that doesn't explicitly
override it to use the default implementation.

Also, the way the weak linkage is done in that patch, means parisc and
um archs that were previously overriding probe_kernel_read() now get
the default probe_kernel_read_strict(), which would be wrong for them.

>=20
> Isn't it probe_kernel_read_strict() and probe_kernel_write_strict() that=20
> you want to add ?
>=20
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> v2:
>> - Enable for all powerpc (suggested by Christophe)
>> - Fold helper function together (Christophe)
>> - Rename uaccess.c to maccess.c to match kernel/maccess.c.
>>=20
>>   arch/powerpc/include/asm/uaccess.h | 25 +++++++++++++++-------
>>   arch/powerpc/lib/Makefile          |  2 +-
>>   arch/powerpc/lib/maccess.c         | 34 ++++++++++++++++++++++++++++++
>=20
> x86 does it in mm/maccess.c

Yeah I'll fix that up, thanks.

Thanks,
Nick
=
