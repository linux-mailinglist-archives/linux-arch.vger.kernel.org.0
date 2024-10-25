Return-Path: <linux-arch+bounces-8586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C820B9B1267
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 00:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F95A1F22A44
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 22:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12A20F3C9;
	Fri, 25 Oct 2024 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+JAxd4N"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087320C32A;
	Fri, 25 Oct 2024 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894494; cv=none; b=TPcL15AXfWw+fZIpS4wlzXmus3k+084v0w7cpeJ9wmNjSpfwlOfhb9I5aeXk4rPZ5E0uwwiolPRdhzYpn/bhz2UDtQ/E7oym/IJR26z7WcOWOs/yTAJeNgJ6cDN2WESM2GNlLRbjQHpNzU9bclQn7eKRU5/2zeukEKINnL26uEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894494; c=relaxed/simple;
	bh=TWzjM8khIqsrgYpO9yGVlEqZ6RsSOMaKDKV6kRm9VRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WiKs9sSW3lSxpY4ici7qPSTJjg7KUZDoVZDGbzyw836eGGOFRPd1hGEufnffiQbQ53odiopTqz7hKFGpDz3xdwnySE870/hSRDgvxWgmlcoQrrmbf0z8/ygdbavFn1h2BLQ4+BhfF1iUrZxOad1VMzasML8Sfk5X59J3MbUyV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+JAxd4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F1CC4CECD;
	Fri, 25 Oct 2024 22:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729894493;
	bh=TWzjM8khIqsrgYpO9yGVlEqZ6RsSOMaKDKV6kRm9VRs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+JAxd4N/2udqHWHQ2ZUbTJu0X8nNA3MYy1pOcSWuJfmjGd0R1BTZ3/YYyTLqIW8h
	 UmMcly99CcMPvEdIkZblRYAkJk6YNi9/XR1QeZTwBozPRVB+/uWGEecaOn70UtkEtn
	 3jW52BC3VtY81VNytr4J6I9wSxoybdYH45D6hya03nDvOK5IRcLQNdON8bhHqq4J0Y
	 GNgbeh+bvQ2eOC9iQ9vapUBglYPmqdfq4B4+s1itafB+RQevSDYcD2m3c2HsuhZPXZ
	 vwnYFhRId8sEBmS5HcieRdWJjYL9GftFZ84/NeKF2uf8/YSKjseEzTlauThqLs6ua8
	 /jvgGwYmxoQyw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso26812081fa.1;
        Fri, 25 Oct 2024 15:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoDYdPQh4eL2XVlnw8ROfNi+V+Qnq78bkXwX0MWAEpV9nlTZiwhKNxoNWei7AcozgpPHLSrq3WcsBRLA==@vger.kernel.org, AJvYcCUoSxCehUnStCygOlNKTbhCkn1hAlc8EfzJO/av8Sb4TWWZm7/Su+3v28GuPf5nFoRbwxitw3M1h/mDD8Q5@vger.kernel.org, AJvYcCVBd80GqT4GY04f6GXF8ClJb9firKfDGCx/99fmDEB94baDzmthEBpWX+F+iXy3WbSvBVXFWXzh97gDaw==@vger.kernel.org, AJvYcCVF9cMlYyqihwYjU1fgemwboj0TrgDujdYrIKjYO3fAc9QthhQjuImFYUwGdpgWJ05niiT9IjVxACGD@vger.kernel.org, AJvYcCVkiJ3UuWEsxkOIouZMm3bLZtqOmqq0815ojRX2QcaeH4Xfhnh/UHXoj9rlSEiQSJMK0nP9znQNeMZWHg==@vger.kernel.org, AJvYcCWAVIL5FtFRGP5CBNAbAt6dzuTkHfGwuWbOciAch1ECKleoahuZvO+AaXKVF2qwRZGKI5vZnngsgkV+Og==@vger.kernel.org, AJvYcCXxbiRDZXWHV4fKPzpp3ITqSKBE4pOBwmVXrUsb5d81wILm0Tem+o3cu/AOsHor/X/rV4sTOuUaDhrbVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JUX55hCJece+iS3MTfn7MVPBdDGgUT7ZSk+coSh2CUk7nfHa
	MHiSg1/DZsH09yJh91pPvVQ+sDnrscJO/cuFDa26Lo+K8po/EeR1r5jdnzdqvIt8M8/ulRm2o2U
	Yp0LxMQT0JM6RK9zHw1+mPZNSj5E=
X-Google-Smtp-Source: AGHT+IHw5+reWhC1oQIY9m5SQPNuq7Xhb2vUG/9BYGHdWen+ojj6Zyd1LnDUzomBJArBjAtNZW5AZrllLzuZYXBcY5Q=
X-Received: by 2002:a2e:bc1d:0:b0:2fb:5723:c9ea with SMTP id
 38308e7fff4ca-2fcbe050581mr3755231fa.30.1729894491494; Fri, 25 Oct 2024
 15:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025191454.72616-1-ebiggers@kernel.org> <20241025191454.72616-19-ebiggers@kernel.org>
In-Reply-To: <20241025191454.72616-19-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 26 Oct 2024 00:14:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfE-Dz8sigPTVmS0C6VcSAMe5O8n4nJk4RDkLZnaaEFg@mail.gmail.com>
Message-ID: <CAMj1kXFfE-Dz8sigPTVmS0C6VcSAMe5O8n4nJk4RDkLZnaaEFg@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] scsi: target: iscsi: switch to using the crc32c library
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 21:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32c().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/target/iscsi/Kconfig              |   2 +-
>  drivers/target/iscsi/iscsi_target.c       | 153 +++++++---------------
>  drivers/target/iscsi/iscsi_target_login.c |  50 -------
>  drivers/target/iscsi/iscsi_target_login.h |   1 -
>  drivers/target/iscsi/iscsi_target_nego.c  |  21 +--
>  include/target/iscsi/iscsi_target_core.h  |   3 -
>  6 files changed, 48 insertions(+), 182 deletions(-)
>
> diff --git a/drivers/target/iscsi/Kconfig b/drivers/target/iscsi/Kconfig
> index 1c0517a12571..2f2f3dc831b8 100644
> --- a/drivers/target/iscsi/Kconfig
> +++ b/drivers/target/iscsi/Kconfig
> @@ -1,11 +1,11 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config ISCSI_TARGET
>         tristate "SCSI Target Mode Stack"
>         depends on INET
> +       select CRC32
>         select CRYPTO
> -       select CRYPTO_CRC32C
>         help
>         Say M to enable the SCSI target mode stack. A SCSI target mode stack
>         is software that makes local storage available over a storage network
>         to a SCSI initiator system. The supported storage network technologies
>         include iSCSI, Fibre Channel and the SCSI RDMA Protocol (SRP).
> diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
> index 6002283cbeba..091c1efccfb7 100644
> --- a/drivers/target/iscsi/iscsi_target.c
> +++ b/drivers/target/iscsi/iscsi_target.c
> @@ -6,11 +6,11 @@
>   *
>   * Author: Nicholas A. Bellinger <nab@linux-iscsi.org>
>   *
>   ******************************************************************************/
>
> -#include <crypto/hash.h>
> +#include <linux/crc32c.h>
>  #include <linux/string.h>
>  #include <linux/kthread.h>
>  #include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/vmalloc.h>
> @@ -488,12 +488,12 @@ void iscsit_aborted_task(struct iscsit_conn *conn, struct iscsit_cmd *cmd)
>
>         __iscsit_free_cmd(cmd, true);
>  }
>  EXPORT_SYMBOL(iscsit_aborted_task);
>
> -static void iscsit_do_crypto_hash_buf(struct ahash_request *, const void *,
> -                                     u32, u32, const void *, void *);
> +static u32 iscsit_crc_buf(const void *buf, u32 payload_length,
> +                         u32 padding, const void *pad_bytes);
>  static void iscsit_tx_thread_wait_for_tcp(struct iscsit_conn *);
>
>  static int
>  iscsit_xmit_nondatain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                           const void *data_buf, u32 data_buf_len)
> @@ -508,13 +508,11 @@ iscsit_xmit_nondatain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>         iov[niov++].iov_len     = ISCSI_HDR_LEN;
>
>         if (conn->conn_ops->HeaderDigest) {
>                 u32 *header_digest = (u32 *)&cmd->pdu[ISCSI_HDR_LEN];
>
> -               iscsit_do_crypto_hash_buf(conn->conn_tx_hash, hdr,
> -                                         ISCSI_HDR_LEN, 0, NULL,
> -                                         header_digest);
> +               *header_digest = iscsit_crc_buf(hdr, ISCSI_HDR_LEN, 0, NULL);
>
>                 iov[0].iov_len += ISCSI_CRC_LEN;
>                 tx_size += ISCSI_CRC_LEN;
>                 pr_debug("Attaching CRC32C HeaderDigest"
>                          " to opcode 0x%x 0x%08x\n",
> @@ -535,15 +533,13 @@ iscsit_xmit_nondatain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                         pr_debug("Attaching %u additional"
>                                  " padding bytes.\n", padding);
>                 }
>
>                 if (conn->conn_ops->DataDigest) {
> -                       iscsit_do_crypto_hash_buf(conn->conn_tx_hash,
> -                                                 data_buf, data_buf_len,
> -                                                 padding, &cmd->pad_bytes,
> -                                                 &cmd->data_crc);
> -
> +                       cmd->data_crc = iscsit_crc_buf(data_buf, data_buf_len,
> +                                                      padding,
> +                                                      &cmd->pad_bytes);
>                         iov[niov].iov_base = &cmd->data_crc;
>                         iov[niov++].iov_len = ISCSI_CRC_LEN;
>                         tx_size += ISCSI_CRC_LEN;
>                         pr_debug("Attached DataDigest for %u"
>                                  " bytes opcode 0x%x, CRC 0x%08x\n",
> @@ -564,12 +560,12 @@ iscsit_xmit_nondatain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>  }
>
>  static int iscsit_map_iovec(struct iscsit_cmd *cmd, struct kvec *iov, int nvec,
>                             u32 data_offset, u32 data_length);
>  static void iscsit_unmap_iovec(struct iscsit_cmd *);
> -static u32 iscsit_do_crypto_hash_sg(struct ahash_request *, struct iscsit_cmd *,
> -                                   u32, u32, u32, u8 *);
> +static u32 iscsit_crc_sglist(const struct iscsit_cmd *cmd, u32 data_length,
> +                            u32 padding, const u8 *pad_bytes);
>  static int
>  iscsit_xmit_datain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                        const struct iscsi_datain *datain)
>  {
>         struct kvec *iov;
> @@ -582,14 +578,12 @@ iscsit_xmit_datain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>         tx_size += ISCSI_HDR_LEN;
>
>         if (conn->conn_ops->HeaderDigest) {
>                 u32 *header_digest = (u32 *)&cmd->pdu[ISCSI_HDR_LEN];
>
> -               iscsit_do_crypto_hash_buf(conn->conn_tx_hash, cmd->pdu,
> -                                         ISCSI_HDR_LEN, 0, NULL,
> -                                         header_digest);
> -
> +               *header_digest = iscsit_crc_buf(cmd->pdu, ISCSI_HDR_LEN, 0,
> +                                               NULL);
>                 iov[0].iov_len += ISCSI_CRC_LEN;
>                 tx_size += ISCSI_CRC_LEN;
>
>                 pr_debug("Attaching CRC32 HeaderDigest for DataIN PDU 0x%08x\n",
>                          *header_digest);
> @@ -612,16 +606,12 @@ iscsit_xmit_datain_pdu(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>
>                 pr_debug("Attaching %u padding bytes\n", cmd->padding);
>         }
>
>         if (conn->conn_ops->DataDigest) {
> -               cmd->data_crc = iscsit_do_crypto_hash_sg(conn->conn_tx_hash,
> -                                                        cmd, datain->offset,
> -                                                        datain->length,
> -                                                        cmd->padding,
> -                                                        cmd->pad_bytes);
> -
> +               cmd->data_crc = iscsit_crc_sglist(cmd, datain->length,
> +                                                 cmd->padding, cmd->pad_bytes);
>                 iov[iov_count].iov_base = &cmd->data_crc;
>                 iov[iov_count++].iov_len = ISCSI_CRC_LEN;
>                 tx_size += ISCSI_CRC_LEN;
>
>                 pr_debug("Attached CRC32C DataDigest %d bytes, crc 0x%08x\n",
> @@ -1402,81 +1392,49 @@ iscsit_handle_scsi_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                 return 0;
>
>         return iscsit_get_immediate_data(cmd, hdr, dump_payload);
>  }
>
> -static u32 iscsit_do_crypto_hash_sg(
> -       struct ahash_request *hash,
> -       struct iscsit_cmd *cmd,
> -       u32 data_offset,
> -       u32 data_length,
> -       u32 padding,
> -       u8 *pad_bytes)
> +static u32 iscsit_crc_sglist(const struct iscsit_cmd *cmd, u32 data_length,
> +                            u32 padding, const u8 *pad_bytes)
>  {
> -       u32 data_crc;
> -       struct scatterlist *sg;
> -       unsigned int page_off;
> -
> -       crypto_ahash_init(hash);
> -
> -       sg = cmd->first_data_sg;
> -       page_off = cmd->first_data_sg_off;
> -
> -       if (data_length && page_off) {
> -               struct scatterlist first_sg;
> -               u32 len = min_t(u32, data_length, sg->length - page_off);
> -
> -               sg_init_table(&first_sg, 1);
> -               sg_set_page(&first_sg, sg_page(sg), len, sg->offset + page_off);
> -
> -               ahash_request_set_crypt(hash, &first_sg, NULL, len);
> -               crypto_ahash_update(hash);
> -
> -               data_length -= len;
> -               sg = sg_next(sg);
> -       }
> +       struct scatterlist *sg = cmd->first_data_sg;
> +       unsigned int page_off = cmd->first_data_sg_off;
> +       u32 crc = ~0;
>
>         while (data_length) {
> -               u32 cur_len = min_t(u32, data_length, sg->length);
> +               u32 cur_len = min_t(u32, data_length, sg->length - page_off);
> +               const void *virt;
>
> -               ahash_request_set_crypt(hash, sg, NULL, cur_len);
> -               crypto_ahash_update(hash);
> +               virt = kmap_local_page(sg_page(sg)) + sg->offset + page_off;
> +               crc = crc32c(crc, virt, cur_len);
> +               kunmap_local(virt);
>
> -               data_length -= cur_len;
>                 /* iscsit_map_iovec has already checked for invalid sg pointers */
>                 sg = sg_next(sg);
> -       }
>
> -       if (padding) {
> -               struct scatterlist pad_sg;
> -
> -               sg_init_one(&pad_sg, pad_bytes, padding);
> -               ahash_request_set_crypt(hash, &pad_sg, (u8 *)&data_crc,
> -                                       padding);
> -               crypto_ahash_finup(hash);
> -       } else {
> -               ahash_request_set_crypt(hash, NULL, (u8 *)&data_crc, 0);
> -               crypto_ahash_final(hash);
> +               page_off = 0;
> +               data_length -= cur_len;
>         }
>
> -       return data_crc;
> +       if (padding)
> +               crc = crc32c(crc, pad_bytes, padding);
> +
> +       return ~crc;
>  }
>
> -static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
> -       const void *buf, u32 payload_length, u32 padding,
> -       const void *pad_bytes, void *data_crc)
> +static u32 iscsit_crc_buf(const void *buf, u32 payload_length,
> +                         u32 padding, const void *pad_bytes)
>  {
> -       struct scatterlist sg[2];
> +       u32 crc = ~0;
>
> -       sg_init_table(sg, ARRAY_SIZE(sg));
> -       sg_set_buf(sg, buf, payload_length);
> -       if (padding)
> -               sg_set_buf(sg + 1, pad_bytes, padding);
> +       crc = crc32c(crc, buf, payload_length);
>
> -       ahash_request_set_crypt(hash, sg, data_crc, payload_length + padding);
> +       if (padding)
> +               crc = crc32c(crc, pad_bytes, padding);
>
> -       crypto_ahash_digest(hash);
> +       return ~crc;
>  }
>
>  int
>  __iscsit_check_dataout_hdr(struct iscsit_conn *conn, void *buf,
>                            struct iscsit_cmd *cmd, u32 payload_length,
> @@ -1660,15 +1618,12 @@ iscsit_get_dataout(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                 return -1;
>
>         if (conn->conn_ops->DataDigest) {
>                 u32 data_crc;
>
> -               data_crc = iscsit_do_crypto_hash_sg(conn->conn_rx_hash, cmd,
> -                                                   be32_to_cpu(hdr->offset),
> -                                                   payload_length, padding,
> -                                                   cmd->pad_bytes);
> -
> +               data_crc = iscsit_crc_sglist(cmd, payload_length, padding,
> +                                            cmd->pad_bytes);
>                 if (checksum != data_crc) {
>                         pr_err("ITT: 0x%08x, Offset: %u, Length: %u,"
>                                 " DataSN: 0x%08x, CRC32C DataDigest 0x%08x"
>                                 " does not match computed 0x%08x\n",
>                                 hdr->itt, hdr->offset, payload_length,
> @@ -1923,14 +1878,12 @@ static int iscsit_handle_nop_out(struct iscsit_conn *conn, struct iscsit_cmd *cm
>                         ret = -1;
>                         goto out;
>                 }
>
>                 if (conn->conn_ops->DataDigest) {
> -                       iscsit_do_crypto_hash_buf(conn->conn_rx_hash, ping_data,
> -                                                 payload_length, padding,
> -                                                 cmd->pad_bytes, &data_crc);
> -
> +                       data_crc = iscsit_crc_buf(ping_data, payload_length,
> +                                                 padding, cmd->pad_bytes);
>                         if (checksum != data_crc) {
>                                 pr_err("Ping data CRC32C DataDigest"
>                                 " 0x%08x does not match computed 0x%08x\n",
>                                         checksum, data_crc);
>                                 if (!conn->sess->sess_ops->ErrorRecoveryLevel) {
> @@ -2326,14 +2279,11 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
>                 rx_got = rx_data(conn, &iov[0], niov, rx_size);
>                 if (rx_got != rx_size)
>                         goto reject;
>
>                 if (conn->conn_ops->DataDigest) {
> -                       iscsit_do_crypto_hash_buf(conn->conn_rx_hash,
> -                                                 text_in, rx_size, 0, NULL,
> -                                                 &data_crc);
> -
> +                       data_crc = iscsit_crc_buf(text_in, rx_size, 0, NULL);
>                         if (checksum != data_crc) {
>                                 pr_err("Text data CRC32C DataDigest"
>                                         " 0x%08x does not match computed"
>                                         " 0x%08x\n", checksum, data_crc);
>                                 if (!conn->sess->sess_ops->ErrorRecoveryLevel) {
> @@ -2686,14 +2636,12 @@ static int iscsit_handle_immediate_data(
>         }
>
>         if (conn->conn_ops->DataDigest) {
>                 u32 data_crc;
>
> -               data_crc = iscsit_do_crypto_hash_sg(conn->conn_rx_hash, cmd,
> -                                                   cmd->write_data_done, length, padding,
> -                                                   cmd->pad_bytes);
> -
> +               data_crc = iscsit_crc_sglist(cmd, length, padding,
> +                                            cmd->pad_bytes);
>                 if (checksum != data_crc) {
>                         pr_err("ImmediateData CRC32C DataDigest 0x%08x"
>                                 " does not match computed 0x%08x\n", checksum,
>                                 data_crc);
>
> @@ -4114,14 +4062,12 @@ static void iscsit_get_rx_pdu(struct iscsit_conn *conn)
>                         if (ret != ISCSI_CRC_LEN) {
>                                 iscsit_rx_thread_wait_for_tcp(conn);
>                                 break;
>                         }
>
> -                       iscsit_do_crypto_hash_buf(conn->conn_rx_hash, buffer,
> -                                                 ISCSI_HDR_LEN, 0, NULL,
> -                                                 &checksum);
> -
> +                       checksum = iscsit_crc_buf(buffer, ISCSI_HDR_LEN, 0,
> +                                                 NULL);
>                         if (digest != checksum) {
>                                 pr_err("HeaderDigest CRC32C failed,"
>                                         " received 0x%08x, computed 0x%08x\n",
>                                         digest, checksum);
>                                 /*
> @@ -4404,19 +4350,10 @@ int iscsit_close_connection(
>          * If any other processes are accessing this connection pointer we
>          * must wait until they have completed.
>          */
>         iscsit_check_conn_usage_count(conn);
>
> -       ahash_request_free(conn->conn_tx_hash);
> -       if (conn->conn_rx_hash) {
> -               struct crypto_ahash *tfm;
> -
> -               tfm = crypto_ahash_reqtfm(conn->conn_rx_hash);
> -               ahash_request_free(conn->conn_rx_hash);
> -               crypto_free_ahash(tfm);
> -       }
> -
>         if (conn->sock)
>                 sock_release(conn->sock);
>
>         if (conn->conn_transport->iscsit_free_conn)
>                 conn->conn_transport->iscsit_free_conn(conn);
> diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
> index 90b870f234f0..c2ac9a99ebbb 100644
> --- a/drivers/target/iscsi/iscsi_target_login.c
> +++ b/drivers/target/iscsi/iscsi_target_login.c
> @@ -6,11 +6,10 @@
>   *
>   * Author: Nicholas A. Bellinger <nab@linux-iscsi.org>
>   *
>   ******************************************************************************/
>
> -#include <crypto/hash.h>
>  #include <linux/module.h>
>  #include <linux/string.h>
>  #include <linux/kthread.h>
>  #include <linux/sched/signal.h>
>  #include <linux/idr.h>
> @@ -69,50 +68,10 @@ static struct iscsi_login *iscsi_login_init_conn(struct iscsit_conn *conn)
>  out_login:
>         kfree(login);
>         return NULL;
>  }
>
> -/*
> - * Used by iscsi_target_nego.c:iscsi_target_locate_portal() to setup
> - * per struct iscsit_conn libcrypto contexts for crc32c and crc32-intel
> - */
> -int iscsi_login_setup_crypto(struct iscsit_conn *conn)
> -{
> -       struct crypto_ahash *tfm;
> -
> -       /*
> -        * Setup slicing by CRC32C algorithm for RX and TX libcrypto contexts
> -        * which will default to crc32c_intel.ko for cpu_has_xmm4_2, or fallback
> -        * to software 1x8 byte slicing from crc32c.ko
> -        */
> -       tfm = crypto_alloc_ahash("crc32c", 0, CRYPTO_ALG_ASYNC);
> -       if (IS_ERR(tfm)) {
> -               pr_err("crypto_alloc_ahash() failed\n");
> -               return -ENOMEM;
> -       }
> -
> -       conn->conn_rx_hash = ahash_request_alloc(tfm, GFP_KERNEL);
> -       if (!conn->conn_rx_hash) {
> -               pr_err("ahash_request_alloc() failed for conn_rx_hash\n");
> -               crypto_free_ahash(tfm);
> -               return -ENOMEM;
> -       }
> -       ahash_request_set_callback(conn->conn_rx_hash, 0, NULL, NULL);
> -
> -       conn->conn_tx_hash = ahash_request_alloc(tfm, GFP_KERNEL);
> -       if (!conn->conn_tx_hash) {
> -               pr_err("ahash_request_alloc() failed for conn_tx_hash\n");
> -               ahash_request_free(conn->conn_rx_hash);
> -               conn->conn_rx_hash = NULL;
> -               crypto_free_ahash(tfm);
> -               return -ENOMEM;
> -       }
> -       ahash_request_set_callback(conn->conn_tx_hash, 0, NULL, NULL);
> -
> -       return 0;
> -}
> -
>  static int iscsi_login_check_initiator_version(
>         struct iscsit_conn *conn,
>         u8 version_max,
>         u8 version_min)
>  {
> @@ -1163,19 +1122,10 @@ void iscsi_target_login_sess_out(struct iscsit_conn *conn,
>                 } else
>                         spin_unlock_bh(&conn->sess->conn_lock);
>                 iscsit_dec_session_usage_count(conn->sess);
>         }
>
> -       ahash_request_free(conn->conn_tx_hash);
> -       if (conn->conn_rx_hash) {
> -               struct crypto_ahash *tfm;
> -
> -               tfm = crypto_ahash_reqtfm(conn->conn_rx_hash);
> -               ahash_request_free(conn->conn_rx_hash);
> -               crypto_free_ahash(tfm);
> -       }
> -
>         if (conn->param_list) {
>                 iscsi_release_param_list(conn->param_list);
>                 conn->param_list = NULL;
>         }
>         iscsi_target_nego_release(conn);
> diff --git a/drivers/target/iscsi/iscsi_target_login.h b/drivers/target/iscsi/iscsi_target_login.h
> index e8760735486b..03c7d695d58f 100644
> --- a/drivers/target/iscsi/iscsi_target_login.h
> +++ b/drivers/target/iscsi/iscsi_target_login.h
> @@ -7,11 +7,10 @@
>  struct iscsit_conn;
>  struct iscsi_login;
>  struct iscsi_np;
>  struct sockaddr_storage;
>
> -extern int iscsi_login_setup_crypto(struct iscsit_conn *);
>  extern int iscsi_check_for_session_reinstatement(struct iscsit_conn *);
>  extern int iscsi_login_post_auth_non_zero_tsih(struct iscsit_conn *, u16, u32);
>  extern int iscsit_setup_np(struct iscsi_np *,
>                                 struct sockaddr_storage *);
>  extern int iscsi_target_setup_login_socket(struct iscsi_np *,
> diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
> index fa3fb5f4e6bc..16e3ded98c32 100644
> --- a/drivers/target/iscsi/iscsi_target_nego.c
> +++ b/drivers/target/iscsi/iscsi_target_nego.c
> @@ -1192,18 +1192,11 @@ int iscsi_target_locate_portal(
>         if (!sessiontype) {
>                 if (!login->leading_connection)
>                         goto get_target;
>
>                 sess->sess_ops->SessionType = 1;
> -               /*
> -                * Setup crc32c modules from libcrypto
> -                */
> -               if (iscsi_login_setup_crypto(conn) < 0) {
> -                       pr_err("iscsi_login_setup_crypto() failed\n");
> -                       ret = -1;
> -                       goto out;
> -               }
> +
>                 /*
>                  * Serialize access across the discovery struct iscsi_portal_group to
>                  * process login attempt.
>                  */
>                 conn->tpg = iscsit_global->discovery_tpg;
> @@ -1256,21 +1249,11 @@ int iscsi_target_locate_portal(
>                 ret = -1;
>                 goto out;
>         }
>         conn->tpg_np = tpg_np;
>         pr_debug("Located Portal Group Object: %hu\n", conn->tpg->tpgt);
> -       /*
> -        * Setup crc32c modules from libcrypto
> -        */
> -       if (iscsi_login_setup_crypto(conn) < 0) {
> -               pr_err("iscsi_login_setup_crypto() failed\n");
> -               kref_put(&tpg_np->tpg_np_kref, iscsit_login_kref_put);
> -               iscsit_put_tiqn_for_login(tiqn);
> -               conn->tpg = NULL;
> -               ret = -1;
> -               goto out;
> -       }
> +
>         /*
>          * Serialize access across the struct iscsi_portal_group to
>          * process login attempt.
>          */
>         if (iscsit_access_np(np, conn->tpg) < 0) {
> diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
> index 60af7c63b34e..51ca80abacf7 100644
> --- a/include/target/iscsi/iscsi_target_core.h
> +++ b/include/target/iscsi/iscsi_target_core.h
> @@ -574,13 +574,10 @@ struct iscsit_conn {
>         spinlock_t              nopin_timer_lock;
>         spinlock_t              response_queue_lock;
>         spinlock_t              state_lock;
>         spinlock_t              login_timer_lock;
>         spinlock_t              login_worker_lock;
> -       /* libcrypto RX and TX contexts for crc32c */
> -       struct ahash_request    *conn_rx_hash;
> -       struct ahash_request    *conn_tx_hash;
>         /* Used for scheduling TX and RX connection kthreads */
>         cpumask_var_t           conn_cpumask;
>         cpumask_var_t           allowed_cpumask;
>         unsigned int            conn_rx_reset_cpumask:1;
>         unsigned int            conn_tx_reset_cpumask:1;
> --
> 2.47.0
>
>

