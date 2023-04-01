Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994CD6D2C80
	for <lists+linux-arch@lfdr.de>; Sat,  1 Apr 2023 03:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjDABju (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 21:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjDABjt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 21:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD0C1D2CE;
        Fri, 31 Mar 2023 18:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338B262CC7;
        Sat,  1 Apr 2023 01:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DB9C433AC;
        Sat,  1 Apr 2023 01:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680313186;
        bh=rb8savxKt4K6ytvuuuSABmkeQZNU+colNLI3/QRhNVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=poEDrl3/4izBNmK7noDcmbEVNHZycNZYThETMqM0Ehs7qKXDAuoepXTHGG66PfoP/
         9bHaqtC+/hxlBnLfXw091uqOPjIqTq0acdkctZHb1qXoP+5nBQn4WQIH8CGhWJt7mc
         xHBD/DvJRXwck0Q2/JiFqZ0Gef8q78x/KWkerpadzHUyqRrwBNip59D+QuShJ+byvz
         53QLigDcNlaERgb3at5w3VU0pn3VTXW1gWKy/3WkXJfUGOh87OiKLTebWs3f8qdgXl
         71is2WXSn8Aka1S3LuMdByeMVBc7pD2BLwKTXrQGUPAQn7EbVp3O9ohmfBLt2H6lhf
         CJ8/eU2+QTXlg==
Received: by mail-ed1-f45.google.com with SMTP id b20so96569124edd.1;
        Fri, 31 Mar 2023 18:39:46 -0700 (PDT)
X-Gm-Message-State: AAQBX9eTfJrOyQPNNE6ssz1nmevnS2fFIdG4w/WNb9CJCB/0TdZhICzI
        YkRx6Nioi2cN8qIjw6xaNneHb6OSE/3TU4EYCKs=
X-Google-Smtp-Source: AKy350Z97xU3SqgbHSjyKKE7QxOxtkjnkYgiFmRi/vHHV7rV7HC6InhW+48wm1PiKntOxFz6eUbQ+OOoaIw/oETlszA=
X-Received: by 2002:a17:907:1002:b0:931:ce20:db96 with SMTP id
 ox2-20020a170907100200b00931ce20db96mr13420368ejb.5.1680313184649; Fri, 31
 Mar 2023 18:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230222033021.983168-1-guoren@kernel.org> <20230222033021.983168-5-guoren@kernel.org>
 <60ee7c26-1a70-427d-beaf-92e2989fc479@spud>
In-Reply-To: <60ee7c26-1a70-427d-beaf-92e2989fc479@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 31 Mar 2023 21:39:32 -0400
X-Gmail-Original-Message-ID: <CAJF2gTQJB3f=80sOsgXpYn7JqfGmq+FSaCwCJ-Er=d7fKhwJcA@mail.gmail.com>
Message-ID: <CAJF2gTQJB3f=80sOsgXpYn7JqfGmq+FSaCwCJ-Er=d7fKhwJcA@mail.gmail.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
To:     Conor Dooley <conor@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 31, 2023 at 2:34=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch converts riscv to use the generic entry infrastructure from
> > kernel/entry/*. The generic entry makes maintainers' work easier and
> > codes more elegant. Here are the changes:
> >
> >  - More clear entry.S with handle_exception and ret_from_exception
> >  - Get rid of complex custom signal implementation
> >  - Move syscall procedure from assembly to C, which is much more
> >    readable.
> >  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
> >  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
> >  - Use the standard preemption code instead of custom
>
> This has unfortunately broken booting my usual NFS rootfs on both my D1
> and Icicle. It's one of the Fedora images from David, I think this one:
> http://fedora.riscv.rocks/kojifiles/work/tasks/3933/1313933/
>
> It gets pretty far into things, it's once systemd is operational that
> things go pear shaped:
>
> [  OK  ] Mounted Huge Pages File System.
> [   70.297439] systemd[1]: Mounted POSIX Message Queue File System.
> [  OK  ] Mounted POSIX Message Queue File System.
> [   70.453489] systemd[1]: Mounted Kernel Debug File System.
> [  OK  ] Mounted Kernel Debug File System.
> [   70.516331] systemd[1]: Mounted Kernel Trace File System.
> [  OK  ] Mounted Kernel Trace File System.
> [   70.679253] systemd[1]: modprobe@configfs.service: Succeeded.
> [   70.788400] systemd[1]: Finished Load Kernel Module configfs.
> [  OK  ] Finished Load Kernel Module configfs.
> [   71.501222] systemd[1]: modprobe@drm.service: Succeeded.
> [   71.573295] systemd[1]: Finished Load Kernel Module drm.
> [  OK  ] Finished Load Kernel Module drm.
> [   71.825934] systemd[1]: modprobe@fuse.service: Succeeded.
> [   71.886945] systemd[1]: Finished Load Kernel Module fuse.
> [  OK  ] Finished Load Kernel Module fuse.
> [   71.991932] systemd[1]: nfs-convert.service: Succeeded.
> [   72.034674] systemd[1]: Finished Preprocess NFS configuration converti=
on.
> [  OK  ] Finished Preprocess NFS configuration convertion.
> [   72.148778] systemd[1]: systemd-modules-load.service: Main process exi=
ted, code=3Dexited, status=3D1/FAILURE
> [   72.256659] systemd[1]: systemd-modules-load.service: Failed with resu=
lt 'exit-code'.
> [   72.337818] systemd[1]: Failed to start Load Kernel Modules.
> [FAILED] Failed to start Load Kernel Modules.
Are you sure, you've compiled all kernel modules? This patch needs all
kernel stuff re-compiled.

> See 'systemctl status systemd-modules-load.service' for details.
> [   72.410491] systemd[1]: systemd-modules-load.service: Consumed 1.463s =
CPU time.
> [   72.496739] systemd[1]: Condition check resulted in FUSE Control File =
System being skipped.
> [   72.513689] systemd[1]: Condition check resulted in Kernel Configurati=
on File System being skipped.
> [   72.682549] systemd[1]: Starting Apply Kernel Variables..
> [  OK  ] Finished Apply Kernel Variables.
> [   76.314434] systemd[1]: Finished Load/Save Random Seed.
> [  OK  ] Finished Load/Save Random Seed.
> [***   ] (1 of 6) A start job is running for=E2=80=A6p Virtual Console (1=
4s / no limit)
> [  OK  ] Finished Create Static Device Nodes in /dev.
> [   79.787065] systemd[1]: Started Entropy Daemon based on the HAVEGE alg=
orithm.
> [  OK  ] Started Entropy Daemon based on the HAVEGE algorithm.
> [   80.186295] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
> [   80.713508] systemd[1]: Starting Rule-based Manager for Device Events =
and Files...
>          Starting Rule-based Manage=E2=80=A6for Device Events and Files..=
.
> [  *** ] (2 of 7) A start job is running for=E2=80=A6 All udev Devices (1=
7s / no limit)
> [   82.939347] systemd[1]: systemd-journald.service: Main process exited,=
 code=3Dexited, status=3D1/FAILURE
> [   83.032046] systemd[1]: systemd-journald.service: Failed with result '=
exit-code'.
> [FAILED] Failed to start Journal Service.
> See 'systemctl status systemd-journald.service' for details.
> [   83.210041] systemd[1]: Dependency failed for Flush Journal to Persist=
ent Storage.
> [DEPEND] Dependency failed for Flus=E2=80=A6Journal to Persistent Storage=
.
> [   83.254122] systemd[1]: systemd-journal-flush.service: Job systemd-jou=
rnal-flush.service/start failed with result 'dependency'.
> [   83.272366] systemd[1]: systemd-journald.service: Consumed 1.443s CPU =
time.
> [   83.334360] systemd[1]: systemd-journald.service: Scheduled restart jo=
b, restart counter is at 1.
> [   83.427839] systemd[1]: Finished Setup Virtual Console.
> [  OK  ] Finished Setup Virtual Console.
> [   83.510650] systemd[1]: Stopped Journal Service.
> [  OK  ] Stopped Journal Service.
> [   83.554417] systemd[1]: systemd-journald.service: Consumed 1.443s CPU =
time.
> [   83.576573] systemd[1]: Condition check resulted in Journal Audit Sock=
et being skipped.
> [   83.904878] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
> [   85.752090] systemd[1]: systemd-journald.service: Main process exited,=
 code=3Dexited, status=3D1/FAILURE
> [   85.826421] systemd[1]: systemd-journald.service: Failed with result '=
exit-code'.
> [   85.876165] systemd[1]: Failed to start Journal Service.
> [FAILED] Failed to start Journal Service.
> See 'systemctl status systemd-journald.service' for details.
> [   85.952221] systemd[1]: systemd-journald.service: Consumed 1.355s CPU =
time.
> [   86.002092] systemd[1]: systemd-journald.service: Scheduled restart jo=
b, restart counter is at 2.
> [   86.015081] systemd[1]: Stopped Journal Service.
> [  OK  ] Stopped Journal Service.
> [   86.076429] systemd[1]: systemd-journald.service: Consumed 1.355s CPU =
time.
> [   86.089700] systemd[1]: Condition check resulted in Journal Audit Sock=
et being skipped.
> [   86.390162] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
> [   87.904427] systemd[1]: systemd-journald.service: Main process exited,=
 code=3Dexited, status=3D1/FAILURE
> [   87.950259] systemd[1]: systemd-journald.service: Failed with result '=
exit-code'.
> [   88.000661] systemd[1]: Failed to start Journal Service.
> [FAILED] Failed to start Journal Service.
> See 'systemctl status systemd-journald.service' for details.
> [   88.079953] systemd[1]: systemd-journald.service: Consumed 1.316s CPU =
time.
> [   88.128956] systemd[1]: systemd-journald.service: Scheduled restart jo=
b, restart counter is at 3.
> [   88.145365] systemd[1]: Stopped Journal Service.
> [  OK  ] Stopped Journal Service.
> [   88.189975] systemd[1]: systemd-journald.service: Consumed 1.316s CPU =
time.
> [   88.205799] systemd[1]: Condition check resulted in Journal Audit Sock=
et being skipped.
> [   88.514817] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
>
> (Note, you need to merge -rc2 into riscv/for-next to actually boot)
>
> Cheers,
> Conor.



--=20
Best Regards
 Guo Ren
