Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA06D27E4
	for <lists+linux-arch@lfdr.de>; Fri, 31 Mar 2023 20:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjCaSer (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Mar 2023 14:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCaSeq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2023 14:34:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729A1CB9B;
        Fri, 31 Mar 2023 11:34:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 830D8B831A0;
        Fri, 31 Mar 2023 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53E8C433EF;
        Fri, 31 Mar 2023 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680287678;
        bh=cFHZKXBfF/aAqc3Fsp181F2WteOHfwqXMSb2SVo24wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ea8m8/H+V5fiadF+7hEBnBK3lItvH3lvCfCUguyEM5G7pmgTYTFrJiQusiFvEg8mN
         3lkVKNXzoZR2jvkUUlxTq6g6/+UbneQxcOrLby7z37mR5VPxvB+GTpdRBulVUL0lp4
         4ZnJ2ipVCUS1vGBi3BwiA0hCIVhdeiVTfngniubtBW8pEo6UuwM+2nUIfraH0L04Xb
         gy1HcfzVUh78BAdlRfhC5DCTGFrALl3/VzWIJxKQzAZy2jERt/OGJBn5+QmwONQsh4
         qvn8ghtm3E3JVeHuzcDOYdAWBOEg/rzaRRFJbXNVclLedWRh9ZO2NDQICIAFNWKbx8
         BtR9TkzaQDyrA==
Date:   Fri, 31 Mar 2023 19:34:31 +0100
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        bjorn@kernel.org, palmer@dabbelt.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH -next V17 4/7] riscv: entry: Convert to generic entry
Message-ID: <60ee7c26-1a70-427d-beaf-92e2989fc479@spud>
References: <20230222033021.983168-1-guoren@kernel.org>
 <20230222033021.983168-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2r0N5+2Ft3yyCaRu"
Content-Disposition: inline
In-Reply-To: <20230222033021.983168-5-guoren@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--2r0N5+2Ft3yyCaRu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 10:30:18PM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> This patch converts riscv to use the generic entry infrastructure from
> kernel/entry/*. The generic entry makes maintainers' work easier and
> codes more elegant. Here are the changes:
>=20
>  - More clear entry.S with handle_exception and ret_from_exception
>  - Get rid of complex custom signal implementation
>  - Move syscall procedure from assembly to C, which is much more
>    readable.
>  - Connect ret_from_fork & ret_from_kernel_thread to generic entry.
>  - Wrap with irqentry_enter/exit and syscall_enter/exit_from_user_mode
>  - Use the standard preemption code instead of custom

This has unfortunately broken booting my usual NFS rootfs on both my D1
and Icicle. It's one of the Fedora images from David, I think this one:
http://fedora.riscv.rocks/kojifiles/work/tasks/3933/1313933/

It gets pretty far into things, it's once systemd is operational that
things go pear shaped:

[  OK  ] Mounted Huge Pages File System.
[   70.297439] systemd[1]: Mounted POSIX Message Queue File System.
[  OK  ] Mounted POSIX Message Queue File System.
[   70.453489] systemd[1]: Mounted Kernel Debug File System.
[  OK  ] Mounted Kernel Debug File System.
[   70.516331] systemd[1]: Mounted Kernel Trace File System.
[  OK  ] Mounted Kernel Trace File System.
[   70.679253] systemd[1]: modprobe@configfs.service: Succeeded.
[   70.788400] systemd[1]: Finished Load Kernel Module configfs.
[  OK  ] Finished Load Kernel Module configfs.
[   71.501222] systemd[1]: modprobe@drm.service: Succeeded.
[   71.573295] systemd[1]: Finished Load Kernel Module drm.
[  OK  ] Finished Load Kernel Module drm.
[   71.825934] systemd[1]: modprobe@fuse.service: Succeeded.
[   71.886945] systemd[1]: Finished Load Kernel Module fuse.
[  OK  ] Finished Load Kernel Module fuse.
[   71.991932] systemd[1]: nfs-convert.service: Succeeded.
[   72.034674] systemd[1]: Finished Preprocess NFS configuration convertion.
[  OK  ] Finished Preprocess NFS configuration convertion.
[   72.148778] systemd[1]: systemd-modules-load.service: Main process exite=
d, code=3Dexited, status=3D1/FAILURE
[   72.256659] systemd[1]: systemd-modules-load.service: Failed with result=
 'exit-code'.
[   72.337818] systemd[1]: Failed to start Load Kernel Modules.
[FAILED] Failed to start Load Kernel Modules.
See 'systemctl status systemd-modules-load.service' for details.
[   72.410491] systemd[1]: systemd-modules-load.service: Consumed 1.463s CP=
U time.
[   72.496739] systemd[1]: Condition check resulted in FUSE Control File Sy=
stem being skipped.
[   72.513689] systemd[1]: Condition check resulted in Kernel Configuration=
 File System being skipped.
[   72.682549] systemd[1]: Starting Apply Kernel Variables..
[  OK  ] Finished Apply Kernel Variables.
[   76.314434] systemd[1]: Finished Load/Save Random Seed.
[  OK  ] Finished Load/Save Random Seed.
[***   ] (1 of 6) A start job is running for=E2=80=A6p Virtual Console (14s=
 / no limit)
[  OK  ] Finished Create Static Device Nodes in /dev.
[   79.787065] systemd[1]: Started Entropy Daemon based on the HAVEGE algor=
ithm.
[  OK  ] Started Entropy Daemon based on the HAVEGE algorithm.
[   80.186295] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[   80.713508] systemd[1]: Starting Rule-based Manager for Device Events an=
d Files...
         Starting Rule-based Manage=E2=80=A6for Device Events and Files...
[  *** ] (2 of 7) A start job is running for=E2=80=A6 All udev Devices (17s=
 / no limit)
[   82.939347] systemd[1]: systemd-journald.service: Main process exited, c=
ode=3Dexited, status=3D1/FAILURE
[   83.032046] systemd[1]: systemd-journald.service: Failed with result 'ex=
it-code'.
[FAILED] Failed to start Journal Service.
See 'systemctl status systemd-journald.service' for details.
[   83.210041] systemd[1]: Dependency failed for Flush Journal to Persisten=
t Storage.
[DEPEND] Dependency failed for Flus=E2=80=A6Journal to Persistent Storage.
[   83.254122] systemd[1]: systemd-journal-flush.service: Job systemd-journ=
al-flush.service/start failed with result 'dependency'.
[   83.272366] systemd[1]: systemd-journald.service: Consumed 1.443s CPU ti=
me.
[   83.334360] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 1.
[   83.427839] systemd[1]: Finished Setup Virtual Console.
[  OK  ] Finished Setup Virtual Console.
[   83.510650] systemd[1]: Stopped Journal Service.
[  OK  ] Stopped Journal Service.
[   83.554417] systemd[1]: systemd-journald.service: Consumed 1.443s CPU ti=
me.
[   83.576573] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[   83.904878] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[   85.752090] systemd[1]: systemd-journald.service: Main process exited, c=
ode=3Dexited, status=3D1/FAILURE
[   85.826421] systemd[1]: systemd-journald.service: Failed with result 'ex=
it-code'.
[   85.876165] systemd[1]: Failed to start Journal Service.
[FAILED] Failed to start Journal Service.
See 'systemctl status systemd-journald.service' for details.
[   85.952221] systemd[1]: systemd-journald.service: Consumed 1.355s CPU ti=
me.
[   86.002092] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 2.
[   86.015081] systemd[1]: Stopped Journal Service.
[  OK  ] Stopped Journal Service.
[   86.076429] systemd[1]: systemd-journald.service: Consumed 1.355s CPU ti=
me.
[   86.089700] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[   86.390162] systemd[1]: Starting Journal Service...
         Starting Journal Service...
[   87.904427] systemd[1]: systemd-journald.service: Main process exited, c=
ode=3Dexited, status=3D1/FAILURE
[   87.950259] systemd[1]: systemd-journald.service: Failed with result 'ex=
it-code'.
[   88.000661] systemd[1]: Failed to start Journal Service.
[FAILED] Failed to start Journal Service.
See 'systemctl status systemd-journald.service' for details.
[   88.079953] systemd[1]: systemd-journald.service: Consumed 1.316s CPU ti=
me.
[   88.128956] systemd[1]: systemd-journald.service: Scheduled restart job,=
 restart counter is at 3.
[   88.145365] systemd[1]: Stopped Journal Service.
[  OK  ] Stopped Journal Service.
[   88.189975] systemd[1]: systemd-journald.service: Consumed 1.316s CPU ti=
me.
[   88.205799] systemd[1]: Condition check resulted in Journal Audit Socket=
 being skipped.
[   88.514817] systemd[1]: Starting Journal Service...
         Starting Journal Service...

(Note, you need to merge -rc2 into riscv/for-next to actually boot)

Cheers,
Conor.

--2r0N5+2Ft3yyCaRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCcntwAKCRB4tDGHoIJi
0mArAP4pqQMIediLrvbLgu1Oy1INpWVZQ5I6KGzgbid6ph2Y1wEAkH+kN4Fi9RCj
xtvqiZXfW4Als+2R4FJMyfQbcFDQGw8=
=rXo/
-----END PGP SIGNATURE-----

--2r0N5+2Ft3yyCaRu--
