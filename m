Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96C17F25F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Mar 2020 09:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCJIye (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 04:54:34 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36055 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCJIye (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2020 04:54:34 -0400
Received: by mail-qk1-f195.google.com with SMTP id u25so11989151qkk.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Mar 2020 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSPxA9X500mgbh9IFPNCBvtp5v+qregrP1EhmFh9wNQ=;
        b=Q05xIIQLHRc1MoiGKDvABRgahTMFDzDQ4Ck1T7qE3LuZVcY7SjB9im3hZXh1MBO8BD
         tQCQ5/nKjtYM51FVdSbLdKJNHTOr07CgOD7VspKmPJLSI2nKDNMYnGh+sgs9eEgdTaTz
         UAtWopKNqaTtn6NQW1GbkupcEFOUnnuOY8xmbv1jNSClQP43hozMkqz7dq3Sywj5LGzc
         NCBDP9dcWc9zXnyQ+e1bkqZJRb9S61qNJVSKpRfNYWkUurvYLqKtbQUUF+Ptg/TB8S2n
         V1Z27CFKbaqbF2MARL6t8YH4yvnrl2r4smaHIfyzrRnX47CCFxgEcqGa2BT07/kWYY2N
         bNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSPxA9X500mgbh9IFPNCBvtp5v+qregrP1EhmFh9wNQ=;
        b=pJRFRZybJXU+J7TeBEgpFeW2SNVksMorV0GWxom2H79ZE48QC8wOy0HT195dod3fmE
         8Nb6lmEhc6Fs02LGb2FyJJFvTUcwA3TVRMNKZb4A6SlaVxH2u1xggXWHZc4D1PnRfDtE
         anBji7zGoVP5Kyc8bj2u/qKV179YnA2AL0kmZZ0BedQ5BdklfEdoKZW/EiJ4EZDt7/wh
         lF+HkDatoz/7Yf6O/Mv733CJ78lZlx4i5y60KA7FNbzESPGS6y5GsEJpgGRJz283liFr
         XfCeEYgMoGKwQKSV0N+udsDBksO1TnmoZDjbMVf76cnJYm5duSClMMPyizCnJlDWC7y5
         rOag==
X-Gm-Message-State: ANhLgQ2A989adTArMgqAlhTyumNQ+ZChau1OIAvci6Sge1E2gjTaBrbJ
        gxdPWvZv+qfNx++MySLa6UnhB17ky0/UfMthoswGtQ==
X-Google-Smtp-Source: ADFU+vtMECKg0iE77xyeveafTTIJe1NctM9ZS1gbqJZXUfdRwOkJDNRqliHHiYwApvHERLRaNfSDyKeu+F6P0l3jIE0=
X-Received: by 2002:a37:a8d8:: with SMTP id r207mr18024852qke.123.1583830471137;
 Tue, 10 Mar 2020 01:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200308094954.13258-1-guoren@kernel.org> <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
 <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
In-Reply-To: <95e3bba4-65c0-8991-9523-c16977f6350f@c-sky.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 10 Mar 2020 16:54:19 +0800
Message-ID: <CAHCEehK0rgBpEzrWar1UTWJoOz=OQi18iw4Y+v3z5Hi=7JCEWw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>
Cc:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 9, 2020 at 6:27 PM LIU Zhiwei <zhiwei_liu@c-sky.com> wrote:
> On 2020/3/9 11:41, Greentime Hu wrote:
> > On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
> >> From: Guo Ren <guoren@linux.alibaba.com>
> >>
> >> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> >> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
> >>
> >> The patch implement basic context switch, sigcontext save/restore and
> >> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
> >> is implemented. We need to discuss about vlen-size for libc sigcontext and
> >> ptrace (the maximum size of vlen is unlimited in spec).
> >>
> >> Puzzle:
> >> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
> >> before, and riscv also met vlen size problem. Let's discuss the common issue
> >> for all architectures and we need a better solution for unlimited vlen.
> >>
> >> Any help are welcomed :)
> >>
> >>   1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
> > Hi Guo,
> >
> > Thanks for your patch.
> > It seems the qemu repo doesn't have this branch?
> Hi Greentime,
>
> It's a promise from me. Now it's ready.  You can turn on vector by
> "qemu-system-riscv64 -cpu rv64,v=true,vext_spec=v0.7.1".
>
> Zhiwei
>
>

Hi Zhiwei,

Thank you, I see the branch in the repo now. I will give it a try and
let you know if I have any problem. :)
