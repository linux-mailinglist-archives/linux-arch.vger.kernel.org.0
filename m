Return-Path: <linux-arch+bounces-10368-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E05A44F27
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 22:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CB3AFDE2
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2025 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A7D517;
	Tue, 25 Feb 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVrGmWER"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09A319CD0B;
	Tue, 25 Feb 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520093; cv=none; b=qboVYM+PKaW10tJFgo5QbQSx2fUhFzhbsW3hSI4GCxfIAJKUEp/eZsrRI/YECjAzCzUn0Zy7Kahe/m8iIL00nOuf4aY//enTEI7848k+uBGeiKYPi3A8yKPVrE3Zq7jH4BmNV3uLkHuVtgZsn40+HDKswQ9Cw4qJdRxnPP7GXtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520093; c=relaxed/simple;
	bh=RyJAkxzvk3zUH+uGiGA2jsWe3R9cWXHmzcPBqABglow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTCbebkVw+FDU87nyF28vmYI0bdjmngP2wCeiJbJd2ECgmjYMGJxFm8J8uM4jeJw/mE0FlpFuSOgL/hg4ua7HUmqtGW5dX+1KJtDXfnCEcOlEJjpeh5YHsx1sOuPqZP81agAD1BlcQi4KVUtsPbpl7cKOoc4uaEq4Y4Iohrvomk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVrGmWER; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbf77b2b64so12300740a91.2;
        Tue, 25 Feb 2025 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520091; x=1741124891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nr1q9ogGR7WS4C9FPvHEUj8w202iJhSEYMosQTeS5U=;
        b=EVrGmWERGlFGkvtEDE9WEu8Zl/IeNN5x8BiO+Ve1SfUOeRCZQ0P9pmmZeTiWsekDAC
         K9Q/a12k8RoCZCHE4AVypixP7OTFfq7GoUBfTP5ExRdVeMxb7nEZ7qWp7HpflgDmFBqk
         Erz6uZfG+4895QKEfirF2jAZUxZ2B6LsLcjMH7897CCCa/GmcKip/RkpBDZ5rDDeHEOz
         PGVi9bqBmRcHTPlneHGpZgDNfOki8IqsHLs38TaYDmMOvfYp2j6KJXXiwBFvNbvP83zg
         IXtuqopW1AL9V9X6agDL16rUWAo3xKyJbNCj/ocF/bKylu3maHeAJXt0sqScARCbUTyX
         sX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520091; x=1741124891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Nr1q9ogGR7WS4C9FPvHEUj8w202iJhSEYMosQTeS5U=;
        b=HpqdSGY0woJ1gi/4YoHVGa8y8tqLj6uSJ9Qj5NSSw8bGaVAE4K/p9BuhEA0hWecHol
         7ZOjAJKUj/+6CbvAwFdFTHludsgoFDyRsKzk306JkWNhmw7KcpXj4a5oGbO6hJKpf7V1
         KhfD7BJrn1Qt59gY/lNdN9ySxvLddL0Gcmgt29PvRHlF5biZBMt6L2ETzMVhxKmFl+TE
         r5JjHLQWu85z6dmGtvy9e9/06E/1ygdzoOcHPchfEQleupgfJlpLGj2yzYvq+ah4yM4Z
         fIWEh549yG/JsMEpMgvOfA1m1AeD3rsdjD5wYh+K0uaJOoI/S+POVQn2lDb0cDNqmeUQ
         WPug==
X-Forwarded-Encrypted: i=1; AJvYcCUG0Y/Q4H78V77Cemvg0mxxUfcKd98J7mepwrAAyeXMRDHsLQUGT12foje/+tDEJVwEYjV7faRRixpr33wI@vger.kernel.org, AJvYcCUJ3+Gv0vexSNH17wHNfhECuPeddOa75sr8E9POuXrEC9tHc+Z0FIcLKnsRW9BSpNmOIMM=@vger.kernel.org, AJvYcCUe/gQI9FuZ0RAG2Ii1H9Ng4hnauWcjZexkaIeak50b3odkPwYZUWbdVYUsyl00IHJVhjcKvOuCo0dCnWLR4NXw@vger.kernel.org, AJvYcCWK+M3WwZiKdWj+P2jpDGs5mTz9bzTDzXTXuq6wF3DRVe5eu5Wg5OOdIsmfL46sDM2zDW0jHQWFIbjWvw==@vger.kernel.org, AJvYcCWfYAJFZGw6xNKoeINJgkhIphvAr0b9+tgPaXNVEelusR3GK6cZEDx8BVaaUIU/jRv100R2bmeSagOVjJnx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EdfJgsi3T3qCeUdQ2AGsqFv9LFvSNuj9z+YBij8f+Kz+V8UW
	EsvwvbOoEITBjcra7TqFq6kRdtYAYZChkjBFrCwkz6z/EzxeWN7OrPqHgn2aW/IADa6qmfoIc8e
	+X3NlU/fopWqD/VW4wxbvBh+6jo8=
X-Gm-Gg: ASbGncsqplGyUxbKTmcU/2lYXu2udASIbJOlcHr1bSOgrKLqWTX6nZp/m2hXqSpdQuA
	TqvlonQavH1nl9adJGTHkH+MrgqBTcIFeQaPDnYszFMS+YrVC4rRSEZq9aeeXIy5XcYFMtOSSkf
	gnZg0kpzWcMGplLkL06GsrjMg=
X-Google-Smtp-Source: AGHT+IGUY5GxwHrH9IJPX2l0nV9GDjkgn1P6C1XkB19TqJbzjv1YvKcnP0eWS4nhqGErbBvrdWLQuNAby+udxpFxNN8=
X-Received: by 2002:a17:90b:524f:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2fe7e3003d8mr1531960a91.13.1740520090935; Tue, 25 Feb 2025
 13:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207012045.2129841-1-stephen.s.brennan@oracle.com>
 <20250207012045.2129841-3-stephen.s.brennan@oracle.com> <CAADnVQLiyezBW34dhkwZw+mWmkFAYMZUdHbOa4uYCdPbgS10SQ@mail.gmail.com>
 <87a5asghj2.fsf@oracle.com> <CAADnVQKLykG3akdPRTDgHDey9FW1LpixZHjLcj+eG2rhXo7V1w@mail.gmail.com>
 <878qq2df4a.fsf@oracle.com>
In-Reply-To: <878qq2df4a.fsf@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 13:47:58 -0800
X-Gm-Features: AWEUYZkaOlIGHZ2FE07XMPsVEj2UF1XOuQhr85knjiH-HVRUnLemTDrSc4LRzrk
Message-ID: <CAEf4BzZT5SSGaEBP3ep6ZZkEqhnznzaAo=EUB-juDzbLwjyErA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btf: Add the option to include global variable types
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Kees Cook <kees@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Sami Tolvanen <samitolvanen@google.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	linux-arch <linux-arch@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, linux-debuggers@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 3:10=E2=80=AFPM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> > On Tue, Feb 11, 2025 at 3:59=E2=80=AFPM Stephen Brennan
> [...]
> >> We can dust that off and include it for a new version of this series.
> >> I'd be curious of what you'd like to see for kernel modules? A
> >> three-level tree would be too complex, in my opinion.
> >
> > What is the use case for vars in kernel modules?
>
> The use case would be the same as for the core kernel. My primary
> motivation is to allow drgn to understand the types of global variables,
> and that extends to kernel modules too.
>
> >> module BTF size increased by 53.2%.
> >
> > This is the sum of all mods with vars divided by
> > the sum of all mods without?
>
> That was a poorly done comparison, so let me provide this one that I did
> using 6.13 and these patches. It was essentially a localmodconfig for a
> VM instance, so I could still do better by picking a popular
> distribution config. But I think this is far more representative.
>
> MODULE                   BASE   COMP    CHG     PCT
> drm.ko                   115833 123410  7577    6.54%
> iscsi_boot_sysfs.ko      2627   5380    2753    104.80%
> joydev.ko                1816   2289    473     26.05%
> libcxgbi.ko              24556  25266   710     2.89%
> drm_vram_helper.ko       22325  22751   426     1.91%
> nvme-tcp.ko              25044  25973   929     3.71%
> vfat.ko                  3448   3953    505     14.65%
> btrfs.ko                 275139 343686  68547   24.91%
> libiscsi.ko              21177  21977   800     3.78%
> xt_owner.ko              449    803     354     78.84%
> nft_ct.ko                4912   6157    1245    25.35%
> iscsi_ibft.ko            3967   4463    496     12.50%
> pcspkr.ko                283    682     399     140.99%
> crc32-pclmul.ko          390    771     381     97.69%
> nf_conntrack.ko          23686  28191   4505    19.02%
> iscsi_tcp.ko             16827  17750   923     5.49%
> nft_fib.ko               835    1117    282     33.77%
> nf_reject_ipv6.ko        699    981     282     40.34%
> rfkill.ko                4233   6410    2177    51.43%
> dm-region-hash.ko        6214   6496    282     4.54%
> cxgb3i.ko                35469  37078   1609    4.54%
> dm-mirror.ko             7576   8191    615     8.12%
> pvpanic-pci.ko           174    574     400     229.89%
> crct10dif-pclmul.ko      146    525     379     259.59%
> nvme-fabrics.ko          17341  18124   783     4.52%
> kvm-amd.ko               47302  51914   4612    9.75%
> crc8.ko                  221    405     184     83.26%
> ib_iser.ko               27769  29116   1347    4.85%
> sg.ko                    4234   5656    1422    33.59%
> intel_rapl_common.ko     5678   8446    2768    48.75%
> bochs.ko                 35643  36997   1354    3.80%
> sha1-ssse3.ko            790    1305    515     65.19%
> kvm-intel.ko             53802  59220   5418    10.07%
> nft_chain_nat.ko         279    714     435     155.91%
> vmlinux                  5484970        7330096 1845126 33.64%
> sha256-ssse3.ko          851    1378    527     61.93%
> nf_nat.ko                6341   7240    899     14.18%
> configs.ko               72     256     184     255.56%
> xt_comment.ko            151    507     356     235.76%
> ccp.ko                   30433  34782   4349    14.29%
> cxgb3.ko                 44981  47504   2523    5.61%
> crypto_simd.ko           1331   1613    282     21.19%
> iptable_filter.ko        855    1456    601     70.29%
> qedi.ko                  70653  72786   2133    3.02%
> drm_kms_helper.ko        63238  65000   1762    2.79%
> cnic.ko                  117074 117790  716     0.61%
> failover.ko              780    1216    436     55.90%
> nft_redir.ko             874    1529    655     74.94%
> serio_raw.ko             708    1234    526     74.29%
> nf_defrag_ipv6.ko        1520   2253    733     48.22%
> nf_defrag_ipv4.ko        306    770     464     151.63%
> nft_reject_ipv4.ko       517    939     422     81.62%
> nft_nat.ko               1192   1732    540     45.30%
> nft_reject_inet.ko       554    976     422     76.17%
> fuse.ko                  32181  41859   9678    30.07%
> nft_compat.ko            3705   4404    699     18.87%
> zstd_compress.ko         42597  43622   1025    2.41%
> tls.ko                   15140  20683   5543    36.61%
> virtio_pci.ko            8456   9193    737     8.72%
> blake2b_generic.ko       1364   1699    335     24.56%
> cryptd.ko                3697   4297    600     16.23%
> xor.ko                   1358   1879    521     38.37%
> intel_rapl_msr.ko        2851   3440    589     20.66%
> kvm.ko                   177060 256377  79317   44.80%
> cxgb4.ko                 215865 220844  4979    2.31%
> bnx2i.ko                 39524  41477   1953    4.94%
> dm-round-robin.ko        1795   2123    328     18.27%
> virtio_pci_legacy_dev.ko 909    1191    282     31.02%
> qla4xxx.ko               79040  82694   3654    4.62%
> nfs.ko                   108350 169642  61292   56.57%
> libata.ko                47301  66188   18887   39.93%
> ghash-clmulni-intel.ko   578    997     419     72.49%
> nf_reject_ipv4.ko        706    988     282     39.94%
> nft_reject.ko            820    1196    376     45.85%
> sunrpc.ko                127496 197841  70345   55.17%
> nft_fib_ipv4.ko          803    1257    454     56.54%
> scsi_transport_iscsi.ko  40419  57633   17214   42.59%
> lockd.ko                 36144  42137   5993    16.58%
> drm_shmem_helper.ko      32555  33043   488     1.50%
> nvme-core.ko             50275  58298   8023    15.96%
> iw_cm.ko                 13405  14796   1391    10.38%
> mdio.ko                  857    1041    184     21.47%
> bnx2.ko                  20354  21611   1257    6.18%
> net_failover.ko          1742   2187    445     25.55%
> ip_set.ko                11812  13093   1281    10.84%
> libcxgb.ko               8698   8980    282     3.24%
> dm-multipath.ko          8124   8898    774     9.53%
> grace.ko                 462    890     428     92.64%
> virtio_net.ko            12322  14896   2574    20.89%
> qed.ko                   228735 232231  3496    1.53%
> cdc-acm.ko               2923   3679    756     25.86%
> i2c-piix4.ko             1124   2341    1217    108.27%
> pvpanic-mmio.ko          177    625     448     253.11%
> virtio_scsi.ko           3154   3898    744     23.59%
> uio.ko                   2602   4295    1693    65.07%
> nft_fib_ipv6.ko          956    1410    454     47.49%
> cec.ko                   28370  29266   896     3.16%
> qemu_fw_cfg.ko           1601   3476    1875    117.11%
> ttm.ko                   23672  25727   2055    8.68%
> sd_mod.ko                9976   13030   3054    30.61%
> xfs.ko                   574594 926637  352043  61.27%
> libiscsi_tcp.ko          17444  17911   467     2.68%
> ib_cm.ko                 32324  62373   30049   92.96%
> aesni-intel.ko           3370   4922    1552    46.05%
> drm_client_lib.ko        27449  27794   345     1.26%
> virtio_pci_modern_dev.ko 2537   2819    282     11.12%
> rdma_cm.ko               32504  51823   19319   59.44%
> fat.ko                   11958  13297   1339    11.20%
> dm-log.ko                6529   6986    457     7.00%
> pata_acpi.ko             9231   9700    469     5.08%
> ata_piix.ko              10998  12598   1600    14.55%
> ipt_REJECT.ko            956    1311    355     37.13%
> drm_ttm_helper.ko        33160  33544   384     1.16%
> be2iscsi.ko              55078  56993   1915    3.48%
> i2c-smbus.ko             582    973     391     67.18%
> cuse.ko                  8435   9241    806     9.56%
> nft_fib_inet.ko          579    995     416     71.85%
> ib_core.ko               103656 123701  20045   19.34%
> pulse8-cec.ko            9153   9890    737     8.05%
> pvpanic.ko               494    1087    593     120.04%
> dm-mod.ko                31377  35265   3888    12.39%
> raid6_pq.ko              2774   4207    1433    51.66%
> nft_reject_ipv6.ko       517    939     422     81.62%
> cxgb4i.ko                47490  49021   1531    3.22%
> ata_generic.ko           9008   9666    658     7.30%
> vboxvideo.ko             47622  48844   1222    2.57%
> ip_tables.ko             3109   3564    455     14.63%
>
> ALL MODS                 9153268        11895301        2742033 29.96%
> vmlinux                  5484970        7330096 1845126 33.64%
> TOTAL                    14638238       19225397        4587159 31.34%
>
> So this shows a 1.8 MiB increase in vmlinux size, or 33.6%.
> And for these modules in aggregate, an increase of 2.7 MiB or 30.0%.
>
> > Any outliers there?
> > I would expect modules to have few global variables.
>
> In terms of outliers, there are groups that stand out to me:
>
> 1. Large percentage increases are usually always for modules that had
> very tiny BTF before. The module system inherently creates a few
> global variables for each module, so there's always a slight constant
> increase of the BTF size (184 bytes, as far as I can tell), and in those
> cases it can be a quite large percentage. Here's an example,
> "configs.ko" which comes from the CONFIG_IKCONFIG enablement:
>
> BEFORE:
>     $ bpftool btf dump file ../build_pahole_novars/kernel/configs.ko -B .=
./build_pahole_novars/vmlinux
>     [127877] CONST '(anon)' type_id=3D11124
>     [127878] ARRAY '(anon)' type_id=3D127877 index_type_id=3D21 nr_elems=
=3D1
>     [127879] CONST '(anon)' type_id=3D127878
>
> AFTER:
>     $ bpftool btf dump file ../build_pahole_vars/kernel/configs.ko -B ../=
build_pahole_vars/vmlinux
>     [162827] CONST '(anon)' type_id=3D11124
>     [162828] ARRAY '(anon)' type_id=3D162827 index_type_id=3D21 nr_elems=
=3D1
>     [162829] CONST '(anon)' type_id=3D162828
>     [162830] VAR '____versions' type_id=3D162829, linkage=3Dstatic
>     [162831] DATASEC '__versions' size=3D64 vlen=3D1
>             type_id=3D162830 offset=3D0 size=3D64 (VAR '____versions')
>     [162832] VAR 'orc_header' type_id=3D8667, linkage=3Dstatic
>     [162833] DATASEC '.orc_header' size=3D20 vlen=3D1
>             type_id=3D162832 offset=3D0 size=3D20 (VAR 'orc_header')
>     [162834] VAR '__this_module' type_id=3D312, linkage=3Dglobal
>     [162835] DATASEC '.gnu.linkonce.this_module' size=3D1344 vlen=3D1
>             type_id=3D162834 offset=3D0 size=3D1344 (VAR '__this_module')
>
> What is, I think interesting, is that the types in that module were
> totally useless to begin with, because they were used by a variable
> which didn't even get emitted. So while this is a substantial
> percentage-wise increase, I think it's a net improvement for this and
> other modules.
>
> 2. The largest absolute increases come from large, complex modules like
> xfs, kvm, sunrpc, btrfs, etc. For example, xfs had 5696 VAR
> declarations. What is disappointing is how much of this is due to
> automatically-generated "variables" from macros (e.g. tracepoints):
> Here is a list of variable prefixes like that:
>
>   print_fmt_*
>   trace_event_fields_*
>   trace_event_type_funcs_*
>   event_*
>   __SCK__tp_func_*
>   __bpf_trace_tp_map_*
>   __event_*
>   event_class_*
>   TRACE_SYSTEM_*
>   __TRACE_SYSTEM_*
>   __tracepoint_*
>
> These are, unfortunately, all valid declarations produced by macros and
> they correspond to valid symbols as well. If you look at the kallsyms
> for the modules (and core kernel), these variables are present there as
> well. It may indeed make sense to have kallsyms entries for them: I
> don't know.
>
> These are all, as far as I'm concerned, totally uninteresting types. If
> you want to access any of this data, you probably already know its type
> and wouldn't need a BTF declaration. Unfortunately, the flip side is
> that I don't think we have a good way to automatically detect these,
> outside of prefix matching, which quickly goes out of date as the kernel
> changes, and can have false positives as well. For kernel modules, many
> of these may appear in separate ELF sections, but for vmlinux, they
> don't. I'd be happy to eliminate types for these auto-generated kinds of
> variables, if we could somehow annotate them so that pahole knows to
> ignore them. For instance, maybe we cauld use
>
> __attribute__((btf_decl_tag("btf_omit")))
>
> as an instruction to pahole to omit declarations for these things?
>

All such tracepoint-related variables, can't we just put them into
some separate ELF section, and teach pahole to ignore global variables
from that section? btf_decl_tag is a similar idea, but (currently)
won't work for GCC-built kernels. So I'd go with the ELF section.

> Thanks,
> Stephen
>
> > So before we decide on what to do with vars in mods lets figure out
> > the need.

